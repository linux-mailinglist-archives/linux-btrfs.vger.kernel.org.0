Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91B6A81FB7
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 17:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbfHEPE0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 11:04:26 -0400
Received: from savella.carfax.org.uk ([85.119.84.138]:44334 "EHLO
        savella.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbfHEPE0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Aug 2019 11:04:26 -0400
X-Greylist: delayed 2391 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Aug 2019 11:04:25 EDT
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1hudua-0008UZ-RC; Mon, 05 Aug 2019 15:24:32 +0100
Date:   Mon, 5 Aug 2019 15:24:32 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] btrfs: add an ioctl to force chunk allocation
Message-ID: <20190805142432.GD24125@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20190802161031.18427-1-josef@toxicpanda.com>
 <7b0e9be3-2239-ecdc-8b7e-a386f1def64f@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <7b0e9be3-2239-ecdc-8b7e-a386f1def64f@gmx.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

   Just to throw a can of turquoise paint into the bike-shed works,
this could be handy with a list of devids to say *where* to create the
new block group.

   This allows for some truly horrible things to happen if abused, but
could also allow for some kind of poor-mans directed-balance: Create a
new block group on the devices you want, balance away one block group
on device(s) you don't want -- data should end up going to the new
empty block group in preference to another new one being automatically
allocated.

   (Alternatively, ignore this suggestion, and I'll just wait for a
proper "move this BG to these devices" ioctl...)

   Hugo.

On Mon, Aug 05, 2019 at 08:24:23PM +0800, Qu Wenruo wrote:
>=20
>=20
> On 2019/8/3 =E4=B8=8A=E5=8D=8812:10, Josef Bacik wrote:
> > In testing block group removal it's sometimes handy to be able to create
> > block groups on demand.  Add an ioctl to allow us to force allocation
> > from userspace.
>=20
> Not sure if we should add another ioctl just for debug purpose.
>=20
> Although I see the usefulness in such debug feature, can we move it to
> something like sysfs so we can hide it more easily?
>=20
> >=20
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/ioctl.c           | 30 ++++++++++++++++++++++++++++++
> >  include/uapi/linux/btrfs.h |  1 +
> >  2 files changed, 31 insertions(+)
> >=20
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index d0743ec1231d..f100def53c29 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -5553,6 +5553,34 @@ static int _btrfs_ioctl_send(struct file *file, =
void __user *argp, bool compat)
> >  	return ret;
> >  }
> > =20
> > +static long btrfs_ioctl_alloc_chunk(struct file *file, void __user *ar=
g)
> > +{
> > +	struct btrfs_root *root =3D BTRFS_I(file_inode(file))->root;
> > +	struct btrfs_trans_handle *trans;
> > +	u64 flags;
> > +	int ret;
> > +
> > +	if (!capable(CAP_SYS_ADMIN))
> > +		return -EPERM;
> > +
> > +	if (copy_from_user(&flags, arg, sizeof(flags)))
> > +		return -EFAULT;
> > +
> > +	/* We can only specify one type at a time. */
> > +	if (flags !=3D BTRFS_BLOCK_GROUP_DATA &&
> > +	    flags !=3D BTRFS_BLOCK_GROUP_METADATA &&
> > +	    flags !=3D BTRFS_BLOCK_GROUP_SYSTEM)
> > +		return -EINVAL;
>=20
> It looks like MIXED bg get less and less love.
>=20
> > +
> > +	trans =3D btrfs_start_transaction(root, 0);
> > +	if (IS_ERR(trans))
> > +		return PTR_ERR(trans);
> > +
> > +	ret =3D btrfs_chunk_alloc(trans, flags, CHUNK_ALLOC_FORCE);
>=20
> And the flags lacks the profile bits, thus default to SINGLE.
> Is it designed or you'd better use btrfs_force_chunk_alloc()?
>=20
> Thanks,
> Qu
>=20
> > +	btrfs_end_transaction(trans);
> > +	return ret < 0 ? ret : 0;
> > +}
> > +
> >  long btrfs_ioctl(struct file *file, unsigned int
> >  		cmd, unsigned long arg)
> >  {
> > @@ -5699,6 +5727,8 @@ long btrfs_ioctl(struct file *file, unsigned int
> >  		return btrfs_ioctl_get_subvol_rootref(file, argp);
> >  	case BTRFS_IOC_INO_LOOKUP_USER:
> >  		return btrfs_ioctl_ino_lookup_user(file, argp);
> > +	case BTRFS_IOC_ALLOC_CHUNK:
> > +		return btrfs_ioctl_alloc_chunk(file, argp);
> >  	}
> > =20
> >  	return -ENOTTY;
> > diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> > index c195896d478f..3a6474c34ad0 100644
> > --- a/include/uapi/linux/btrfs.h
> > +++ b/include/uapi/linux/btrfs.h
> > @@ -943,5 +943,6 @@ enum btrfs_err_code {
> >  				struct btrfs_ioctl_get_subvol_rootref_args)
> >  #define BTRFS_IOC_INO_LOOKUP_USER _IOWR(BTRFS_IOCTL_MAGIC, 62, \
> >  				struct btrfs_ioctl_ino_lookup_user_args)
> > +#define BTRFS_IOC_ALLOC_CHUNK _IOR(BTRFS_IOCTL_MAGIC, 63, __u64)
> > =20
> >  #endif /* _UAPI_LINUX_BTRFS_H */
> >=20
>=20




--=20
Hugo Mills             | We don't just borrow words; on occasion, English h=
as
hugo@... carfax.org.uk | pursued other languages down alleyways to beat them
http://carfax.org.uk/  | unconscious and rifle their pockets for new
PGP: E2AB1DE4          | vocabulary.                           James D. Nic=
oll

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE3YTVWJ2B3e6TDSBUWF4UdeKrHeQFAl1IPBsACgkQWF4UdeKr
HeTUSg//W2dGjbSQl4dI3n7ho5yWAs8LUsccvcWk5MK/fdRUr3CgbeMdCbnxeyEk
kOEjUE2cgJ88tMiq/xMh9wfvkJCqBe4rU/yahbTxZKrKikX2aBUJGglSXqxvCwMS
X1cXsdrhdauQlXTPJZSiLpFUHtWAzlwWGp5LTKkSgDVfjVAgdlCUmyjQF/jo3J8A
dTNyNwnpqtn1KAHVmglrwmqCad8rFPh49ps5WSJr5tp+ML0tDdfmZBkbxXphdJl7
P1FlIcFHt55Udf+6VxqzEEXHTNI+pHAyIY+cdJcvFcaUqrwxCIg/wX2sg9xxfAv4
jm5MDYSC7jRGmJLH5X1GuXBhOeU/48C252VNS40Pt/TdFhO6q1RtdLFkYv/dzvXE
gaP3tXNemwAGfKxOdwwcQEh2wY4B7xgYx4wNiPeF771gWdP7MKXQhf5jJbnDlmsW
xleku71EvKbB2vcIrxlB17DHbUNIgwe5BVKf5y3PSKip1HBzM91PDOwTpkG7R5qc
OK5OIDXF9GrmfaP2VsMaa5ij++MD7knIe1UXtlJagiOEmXOx0OGK9b1r81WqGMtz
JnGUBj3XlPf6nHPnDUEaRym5lyoZvKemr9QWrjgFfqycEADynsNGAArJeBNdohgS
B3mFb4ixMipCc0g7jQSwbJLf8F6YjODSDM0+NyF86WRfKoe6rl4=
=+dNP
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--

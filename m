Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2F2160B6E
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 08:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgBQHKv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 02:10:51 -0500
Received: from mout.gmx.net ([212.227.15.15]:35921 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgBQHKu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 02:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581923214;
        bh=LDPyWvs6hn/kvyk5EoUGuzLbR82uxW2c49akT6R9BlA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=kIkepvCNmAAvVsI2a4LP0yFe3uZYPb2rld6MxUGfGTM+pSP91QTRcz0p5SzQYxzR7
         4NEuLYCq5HdMzdeO8bwU+blz/JqtSn0u5i0bRqT75T1SQDrRpj2p9BkYfhLCfNo4uO
         dYbW2WZuUh8yeHXof2g3iSTj1abh6F/e5R7+uXLk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N4hzZ-1jUz2v08Rz-011flZ; Mon, 17
 Feb 2020 08:06:54 +0100
Subject: Re: [PATCH] btrfs: Add comment for BTRFS_ROOT_REF_COWS
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200212074651.33008-1-wqu@suse.com>
 <20200214165334.GC2902@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <54ffe5f9-19d1-f916-04fa-3eceedc5aca7@gmx.com>
Date:   Mon, 17 Feb 2020 15:06:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200214165334.GC2902@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XHTiaAfSgKNWxvjPsENRDpYvffyooMwb5"
X-Provags-ID: V03:K1:fWbQYRUUD2pVMUCeZ5Pi+pTsS60Fez1i8KJQ8dF8DvjGIxwPDmk
 DJFkkUwAoXEyyZEdHQhXQ6yIZaaA2wZdiF2CkLIeqHLQdjzloJ9X8U3YTOUYmQ+4jxh0ktd
 GZdoiH/dol9vsmRPsAMz+Z8KMy9nyh+q0zglTOsG209ZSu1A5jRtXbMFZqPz8+JKbJzo8t/
 9jrJr+AKkojFJ7UGdjBmw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fpmd2pBAD90=:TG+q7ve05nbIEZ0AfEhtbh
 EcOVHvbTv0OqQy8ztxTb7VQUbkhqbUuyb2z//v+tO2xEkOX2ZTzC5CDfbbCC9Jgl9A8feZwFi
 FwR6+ly9kNwWg6E/DvMgZFVgOKd9IQ7akGE/Aga7oGPIZskdSTgAnfOK0rElETU1hUVpWMsJP
 x1iNJVee4c09V9FVQoqNmkVxIKW+DO6ULOBH03SPtWWvUER8pnW8fPz++RzLHIqEVR8WgyJUc
 tOSTSG4YVlk/58P+6RTEogxLAsPLR2lG6fCRgLXQn5hVZzIiIxN19m3iG12prbj1DeoEXmPwo
 4f2JK/AETG3iue7k/zCHLP/Ef8P+yP11wEjWyr3qZ45Qn0toDFO1t2cPFou03vHkFS2DfNmiB
 82h4d/ijuC7LXC1ag3K0QtvyczOtfbssCoPhQcnTsWwZT8PhEOT3LP62bGeV/QsXcKYqL6e9w
 xP41io8levtflhHoM4cOpbOUoISWSrxTqpvzQQ05e48h3/h83oBGnk3ZOdmeNDriArT09bDH/
 vggZtS+Isc+5fcO2CejB0CJTAg910oDXeiDWEaFjKqRKSemtYvy4uYactExfN36pE6goWkJ/o
 Eg5t11AX8onsFUZlbZlsGtAdzUGuvC2vS416XRNnbOSLQDTF2mf5q+26pv1DnVD8vdU+/fldN
 RXPmYcS5DQTZ6NGV5yr8cWrnpP2ytD3Uae4qQjh9sELiGkIml7fTgmAm+mAu76gaQzvZLschB
 +mftQuzVQKctUVlP6zMNpIv1ezGQ1woYZB25uz/Zo58LWw7bRcMssSaDIuYv/HWWa96BuW9Mq
 tDpxFzJYJNGJikARXG5JFyh6kAY4dKEWKn/y6zbVZfn2bAYbMQDdEyNZeJ/bDjWboLhTtU1pP
 E5HqvafVyIOMlQRRJW6eys5ahfA5KymasSZLBsKpzc0kCR2w4cvgFtZ0iLNlPdpsVcLJFaCE/
 V4RadDGomsFPOUVpP9sNleUZVaMm9rZgEdJlLlUHeLgugDDYYKXRx0UwgSYEzP6iJUZDZy+mx
 PVDkrzRvEx0tR1gbJPG022LKyJ4QZyAiA1v9NYZHrGQR6iKttQDg7WZA6VeMSWPt9RgUVLN+l
 k345yJrN+kEqxl6zbTNkgCn6KsSSwKGlsGhtt7XZD6X/GYPP6IEHMitqEx2vdfxsOV7e5pSW4
 cg6d9lom4BzFK9n+ygK1uKhhY3P+B3OPvhYsSYTa8EFI6iiEA3IWBjSn1rXMvCYCU/3U3knyG
 hAaaHcSJst+NFuToa
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XHTiaAfSgKNWxvjPsENRDpYvffyooMwb5
Content-Type: multipart/mixed; boundary="ezW0ZxuaLxk5zLf8ji8ycsXmNtW9gPOTn"

--ezW0ZxuaLxk5zLf8ji8ycsXmNtW9gPOTn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/15 =E4=B8=8A=E5=8D=8812:53, David Sterba wrote:
> On Wed, Feb 12, 2020 at 03:46:51PM +0800, Qu Wenruo wrote:
>> This bit is being used in too many locations while there is still no
>> good enough explaination for how this bit is used.
>>
>> Not to mention its name really doesn't make much sense.
>>
>> So this patch will add my explanation on this bit, considering only
>> subvolume trees, along with its reloc trees have this bit, to me it
>> looks like this bit shows whether tree blocks of a root can be shared.=

>=20
> I think there's more tan just sharing, it should say something about
> reference counted sharing. See eg. btrfs_block_can_be_shared:
>=20
>  864         /*
>  865          * Tree blocks not in reference counted trees and tree roo=
ts
>  866          * are never shared. If a block was allocated after the la=
st
>  867          * snapshot and the block was not allocated by tree reloca=
tion,
>  868          * we know the block is not shared.
>  869          */
>=20
> And there can be more specialities found when grepping for REF_COWS. Th=
e
> comment explaination should be complete or at least mention what's not
> documenting. The I find the suggested version insufficient but don't
> have a concrete suggestions for improvement. By reading the comment and=

> going through code I don't feel any wiser.
>=20

I see nothing extra conflicting the "shared tree blocks" part from
btrfs_block_can_be_shared().

In fact, reloc tree can only be created for trees with REF_COW bit.

For tree without that bit, we go a completely different way to relocate
them, by just cowing the path (aka the cowonly bit in build_backref_tree(=
)).

	if (root) {
		if (test_bit(BTRFS_ROOT_REF_COWS, &root->state)) {
			BUG_ON(node->new_bytenr);
			BUG_ON(!list_empty(&node->list));
			btrfs_record_root_in_trans(trans, root);
			root =3D root->reloc_root;
			node->new_bytenr =3D root->node->start;
			node->root =3D root;
			list_add_tail(&node->list, &rc->backref_cache.changed);
		} else {
			path->lowest_level =3D node->level;
			ret =3D btrfs_search_slot(trans, root, key, path, 0, 1);  <<<
			btrfs_release_path(path);
			if (ret > 0)
				ret =3D 0;
		}

So the "REF_COW means tree blocks can be shared" still looks pretty
valid to me.

Thanks,
Qu


--ezW0ZxuaLxk5zLf8ji8ycsXmNtW9gPOTn--

--XHTiaAfSgKNWxvjPsENRDpYvffyooMwb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5KO4kXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qg+gwf/ZJ0Z3yXxr9LuXkzN4itT5lRL
8EiUKy7DdNMiqymNR4/xeQLdlI8iZSoD/02BzRqWRUyVJNgiK96uE0vozIu5tXqd
bC7Esyn+r9ytK9a9XMTFVSseWGfBw5eksjK3km4vSkl4fPCKEtBfzZOEBR2bx9Ca
/UhcEKMUUbRbwgZuy9IK2f2XTd2XJ/8eAqNLIjS1lTerAryUlj24oW5e3c/10LlB
FOOTtjqd0ErRIDRWKeQLiD36NGDxZ8wzREzpZRn57APje8He50htUAkohbOpubB0
vJ12AQF7CYGlxe0IbOwxPvWyzHsYWBY7ZV3tBV7OP/X0cUTDiYF5roiulJ2ahw==
=P28g
-----END PGP SIGNATURE-----

--XHTiaAfSgKNWxvjPsENRDpYvffyooMwb5--

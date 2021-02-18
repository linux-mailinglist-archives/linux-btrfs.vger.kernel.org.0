Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAC531F176
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Feb 2021 21:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhBRU5I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Feb 2021 15:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBRU4x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Feb 2021 15:56:53 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40048C0613D6
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Feb 2021 12:56:13 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1lCqLK-0003Nl-QW; Thu, 18 Feb 2021 20:56:10 +0000
Date:   Thu, 18 Feb 2021 20:56:10 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Samir Benmendil <me@rmz.io>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: BTRFS error (device dm-0): block=711870922752 write time tree
 block corruption detected
Message-ID: <20210218205610.GW4090@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Samir Benmendil <me@rmz.io>, linux-btrfs@vger.kernel.org
References: <20210217132640.r44q7ccfz2fohvxy@hactar>
 <20210217134502.GU4090@savella.carfax.org.uk>
 <F222B7F7-84A4-4681-85FE-2EAA81446B21@rmz.io>
 <20210218204602.d63ix6us3sp7fj3m@hactar>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
In-Reply-To: <20210218204602.d63ix6us3sp7fj3m@hactar>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 18, 2021 at 08:46:02PM +0000, Samir Benmendil wrote:
> On Feb 17, 2021 at 16:56, Samir Benmendil wrote:
> > On 17 February 2021 13:45:02 GMT+00:00, Hugo Mills <hugo@carfax.org.uk>
> > wrote:
> > > On Wed, Feb 17, 2021 at 01:26:40PM +0000, Samir Benmendil wrote:
> > > > Any advice on what to do next would be appreciated.
> > > 
> > >   The first thing to do is run memtest for a while (I'd usually
> > > recomment at least overnight) to identify your broken RAM module and
> > > replace it. Don't try using the machine normally until you've done
> > > that.
> > 
> > Memtest just finished it's first pass with no errors, but printed a note
> > regarding vulnerability to high freq row hammer bit flips.
> > 
> > I'll keep it running for a while longer.
> 
> 2nd pass flagged a few errors, removed one of the RAM module, tested again
> and it passed. I then booted and ran `btrfs check --readonly` with no
> errors.
> 
>     [root@hactar ~]# btrfs check --readonly /dev/mapper/home_ramsi
>     Opening filesystem to check...
>     Checking filesystem on /dev/mapper/home_ramsi
>     UUID: 1e0fea36-a9c9-4634-ba82-1afc3fe711ea
>     [1/7] checking root items
>     [2/7] checking extents
>     [3/7] checking free space cache
>     [4/7] checking fs roots
>     [5/7] checking only csums items (without verifying data)
>     [6/7] checking root refs
>     [7/7] checking quota groups skipped (not enabled on this FS)
>     found 602514441102 bytes used, no error found
>     total csum bytes: 513203560
>     total tree bytes: 63535939584
>     total fs tree bytes: 58347077632
>     total extent tree bytes: 4500455424
>     btree space waste bytes: 15290027113
>     file data blocks allocated: 25262661455872
>     referenced 4022677716992
> 
> 
> Thanks again for your help Hugo.

   Great news.

   Hugo.


-- 
Hugo Mills             | The early bird gets the worm, but the second mouse
hugo@... carfax.org.uk | gets the cheese.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE3YTVWJ2B3e6TDSBUWF4UdeKrHeQFAmAu1GUACgkQWF4UdeKr
HeSl7g/+JGPrbRKAmo0S+q6zi13CfpHvBQUIIzSa6XBTj+0GubKrcbj5v5jajXTq
0SqNq3OBKIp+M8tJfR2jSoDuOBtNc5XhytQuKjBJexL08EE0VHs4LQjQATyYQ+md
g9w1D1J6AL1bTY0oGUJvztWn/tYQNYhQP1zOrFpM2owqAIJTQd1kccwFEIEk+t8u
CA2uXqyyTqwt4/UB1tzta71hlnEB27DL3XP6a0l5vv8OodJVt2eph838DpHrzIsy
CQ1zgjh/T7hRKlp/Tk0QpOx2eOL4AlrgASMxWmhszCH1DeodOviiYC3eFC9PL1fA
FWWB/Ms11MUIaewUOkL05K2m7EGOpwz8M5ZVdrnPz8ylnJ8NA9mE1IUwyP6IsGY1
eRHItexJx9R0KPKNXBAsVGqs9RNU7WP1wzCGHFvGC2aPYy6/iCMn7QlybmqJEqt/
VoKlm76Bh2Jsgh0B1CJvWBpA7PT+AiVeoZL4bMrUC7A9x71H/HK8dv441ebaMkac
BbURfUVHHYmYFZKKzcwyel0lMEPfOYwOEVzEUJemIUJcYKuilI8gl0j/e7OxRFdD
yZSszgxx2pjfh26aBUeC7KqGC3zNnVdm8fw6baAKg5iptdQi6vqbqZKDm815Pcm+
kUpMhmql1nz/4w+JN0O8VH6wOq1QkW1v2gNvB/bke8ftcGMEwds=
=d7zo
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--

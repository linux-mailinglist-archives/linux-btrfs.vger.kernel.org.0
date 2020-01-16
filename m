Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1CEA13D12D
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 01:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgAPAeF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 19:34:05 -0500
Received: from mars1.mruiz.dev ([167.71.125.59]:59266 "EHLO mars1.mruiz.dev"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729110AbgAPAeF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 19:34:05 -0500
Received: from archlinux.localnet (unknown [172.58.35.155])
        by mars1.mruiz.dev (Postfix) with ESMTPSA id A424240734
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2020 00:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mruiz.dev; s=201908;
        t=1579134844; bh=vTeSbOhNcxEgLRz+B0EGpdUL1I+LQgQ9y5/ANJ5FZko=;
        h=From:To:Subject:Date:From;
        b=MXD2N+cGLJmiaYFLKqbi79hK2pvYNVrYBAvx4M+B6UpqqwX37QT/+BEMW7KG5QiEi
         GLGAP1qHoamF9ChEseKN6ABO7eRqIigX0JQR8+17Um2zKwSxIkrpMKO3IYU+PhDSen
         vrc6FMSGyNldcx7r3jidFcNGwBk3ooFGbMN26T92is9dqOFt8Pe0sxCCRUDvx2WB8c
         Gs3Hy6h+5yZbOlvHkH4K4+XcnE8VN7e0Ge3w94/rCYi4G5ECr+8kUCB+yawuiJM9zr
         xYZ5PJd6BwwJYANp/St4OI0Cp/eyeM+n75LUJpXTljCBKd2fggDaVMgrX/KJbhk250
         by5CGU12inwsw==
From:   Michael Ruiz <michael@mruiz.dev>
To:     linux-btrfs@vger.kernel.org
Subject: Linux swap file not activating after reboot
Date:   Wed, 15 Jan 2020 16:34:02 -0800
Message-ID: <5318295.DvuYhMxLoT@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5561676.lOV4Wx5bFT"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart5561676.lOV4Wx5bFT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,
 I have a //@swap subvolume and i have a swapfile within it. I mount the 
subvolume like such in fstab:

`rw,ssd,nofail,noautodefrag,nodatacow,nodatasum,subvolid=1234,subvol=/@swap`

It mounts correctly, but 1/15/20 4:20 PM kernel I get: 

`BTRFS warning (device dm-0): swapfile must not be copy-on-write`

I did chattr +C on the empty swapfile as per arch wiki instructions. The only 
problem is that it does not work after reboot... Does btrfs allow subvolumes 
to have different mount options?
--nextPart5561676.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEr70V3EMiSIOlxR/PXLDtxglpeu0FAl4fr3EACgkQXLDtxglp
eu0cvwgAtrFWOX9SJL0VEXwJVX1KRwEFeN9eydiP0TIj0qz6VC4aWz5PjFrHi9Gq
Y57UVkS65toQpo4LdqcVrBfJIb2GYieK42cSjfhBIhrXtuq+zJId5mkjKhKsBZEA
UB2IA22dMyx9VqBlB9AyTyzECFV1cKkCZhp0CIMlRh+O5JHEW8kEPRY/qJkZyBiz
Wnbh7WNcPyqp3wQYN85Im7QS3WxYqnznEx4psG8HahlavkWni1kzWqprXuSac2Af
noJa5+2SsfFkzVkNv26z7W+wfhuTkJ+im3e5e65Zx27iareSDVx3mri+4nDBtHuc
CSbRNL7k9ELjvgV9Jninl5FHY5au6Q==
=Gj5C
-----END PGP SIGNATURE-----

--nextPart5561676.lOV4Wx5bFT--




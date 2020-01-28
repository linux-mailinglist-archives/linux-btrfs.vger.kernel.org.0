Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53B6214BC92
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2020 16:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgA1PFs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jan 2020 10:05:48 -0500
Received: from smtpauth.rollernet.us ([208.79.240.5]:52217 "EHLO
        smtpauth.rollernet.us" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgA1PFr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jan 2020 10:05:47 -0500
Received: from smtpauth.rollernet.us (localhost [127.0.0.1])
        by smtpauth.rollernet.us (Postfix) with ESMTP id EC34B2800069;
        Tue, 28 Jan 2020 07:05:41 -0800 (PST)
Received: from irrational.integralblue.com (pool-96-237-186-35.bstnma.fios.verizon.net [96.237.186.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by smtpauth.rollernet.us (Postfix) with ESMTPSA;
        Tue, 28 Jan 2020 07:05:41 -0800 (PST)
Received: from www.integralblue.com (irrational [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by irrational.integralblue.com (Postfix) with ESMTPSA id 7C96D559DD82;
        Tue, 28 Jan 2020 10:05:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=integralblue.com;
        s=irrational; t=1580223937;
        bh=9lMvwhsJeSrraBWG6533qFsVay5Y4NvujbfC/dnRTTs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=nMM+PBaBG/VWxEwA5a+A93t8Yr/iFychjtQd2RPBhO+OmBhZXKhTi/7lwL+jpFbC5
         8DrD7GxGDJrQVbwCU1hZMnMwPBeQNCROt3RjgHoXe2hLv2+QXFTGtDqALUCXbCmQgS
         5DH9DwYpeX26VuptZ4jsetdINqKkXiOQ8m6Y7HC8=
MIME-Version: 1.0
Content-Type: multipart/signed;
 protocol="application/pgp-signature";
 boundary="=_eb1f484ab09911b8433f6dc35690e9e7";
 micalg=pgp-sha1
Date:   Tue, 28 Jan 2020 10:05:37 -0500
From:   Craig Andrews <candrews@integralblue.com>
To:     fdmanana@gmail.com
Cc:     =?UTF-8?Q?St=C3=A9phane_Lesimple?= <stephane_btrfs2@lesimple.fr>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Regression in Linux 5.5.0-rc[1-5]: btrfs send/receive out of
 memory
In-Reply-To: <CAL3q7H5FHc9ooNOP3CnXas=_H_BEZN5mzegVMuvtoXgT9nxL6A@mail.gmail.com>
References: <5ba0716449eb4f838699fc0b1fb5b024@integralblue.com>
 <20200113133741.GU3929@twin.jikos.cz>
 <7e7e4f63a89b6bb8a270d4c4ec676835@integralblue.com>
 <8254df450ca61dd4cbc455f19ee28c01@lesimple.fr>
 <CAL3q7H4-3Mg2GUf2JMMFem77sSQR5opN9dxdvHz2kk1Qd=RD=A@mail.gmail.com>
 <06639bb0a512aff6ed8a41bffb033f35@integralblue.com>
 <CAL3q7H5FHc9ooNOP3CnXas=_H_BEZN5mzegVMuvtoXgT9nxL6A@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <f2ca887d98c1b5aacc4dde88cba74d98@integralblue.com>
X-Sender: candrews@integralblue.com
X-Rollernet-Abuse: Processed by Roller Network Mail Services. Contact abuse@rollernet.us to report violations. Abuse policy: http://www.rollernet.us/policy
X-Rollernet-Submit: Submit ID 287a.5e304dc5.e5958.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)

--=_eb1f484ab09911b8433f6dc35690e9e7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8;
 format=flowed

On 2020-01-28 10:02, Filipe Manana wrote:
> On Tue, Jan 28, 2020 at 2:46 PM Craig Andrews 
> <candrews@integralblue.com> wrote:
>> 
>> On 2020-01-27 08:44, Filipe Manana wrote:
>> > On Sat, Jan 25, 2020 at 11:18 AM Stéphane Lesimple
>> > <stephane_btrfs2@lesimple.fr> wrote:
>> >>
>> >> > ERROR: failed to clone extents to var/amavis/db/__db.001: Invalid argument
>> >>
>> >> If I may add another data point here, I'm also encountering this issue
>> >> on a 5.5.0-rc6, with the btrfs-rc7 patches applied to it (so as far as
>> >> btrfs is concerned, this is an rc7).
>> >>
>> >> On the first time, it happened after sending ~90 Gb worth of data, and
>> >> aborted (as I didn't specify the -E option to btrfs send). Then, I
>> >> retried with btrfs send -E 0, and it encountered the exact same error
>> >> on the same file.
>> >>
>> >> # btrfs send -v /tank/backups/.snaps/incoming/sendme/ | pv
>> >> 2>/dev/pts/23 | btrfs rec -E 0 /newfs/
>> >> At subvol /tank/backups/.snaps/incoming/sendme/
>> >> At subvol sendme
>> >> ERROR: failed to clone extents to
>> >> retroarch/x86_64/cores/mednafen_saturn_libretro.dll: Invalid argument
>> >> ERROR: failed to clone extents to
>> >> retroarch/x86_64/cores/mednafen_saturn_libretro.dll: Invalid argument
>> >
>> > This is probably the same case for which I sent a fix last week:
>> >
>> > https://patchwork.kernel.org/patch/11350129/
>> >
>> > Thanks.
>> 
>> I applied that patch to 5.5.0-rc7 and that solved the problem. I can 
>> now
>> do backups (which is a send/receive) successfully.
>> 
>> >
>> >>
>> >> The send/receive is still going on for now, currently around the ~200
>> >> Gb mark.
>> >>
>> >> Bees is running on this FS (but I stopped it before doing the
>> >> send/receive).
>> >>
>> >> I can test patches if needed.
>> >>
>> >> --
>> >> Stéphane.
>> 
>> The patch appears to have fixed my problems - thank you!
> 
> Great!
> 
> Can you reply to the patch's thread with a:
> 
> Tested-by: Your Name <email@foo.bar>
> 
> ?
> 
> Or I can reply to it myself with that if you agree.
> 
> Thanks!
> 
>> ~Craig


Can you please send the reply?
Tested-by: Craig Andrews <candrews@integralblue.com>

And again, thank you!
~Craig

--=_eb1f484ab09911b8433f6dc35690e9e7
Content-Type: application/pgp-signature;
 name=signature.asc
Content-Disposition: attachment;
 filename=signature.asc;
 size=195
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRXYh1D8NS5wgKWveFHeNF+DbGKQgUCXjBNwQAKCRBHeNF+DbGK
QqKEAJ0W3Au7j46pvlfyu428NVy7dZOb9wCgvKXFqLeW+O5cMp6Bgq8j/zqB1vc=
=hLjF
-----END PGP SIGNATURE-----

--=_eb1f484ab09911b8433f6dc35690e9e7--

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CAF390C69
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 00:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhEYWth (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 18:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhEYWtg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 18:49:36 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687BEC061760
        for <linux-btrfs@vger.kernel.org>; Tue, 25 May 2021 15:48:05 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id l70so23948126pga.1
        for <linux-btrfs@vger.kernel.org>; Tue, 25 May 2021 15:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=lQU/mw2gew9Xsu/0BklV7sCPI0gkzm5yQeyxIIbvBKw=;
        b=HMjd6r8WAvXPNaQI4bYAP8fKI8dQWuW89LsVrprrgTOuU5+BFUxRmFqVp3hgOAxagR
         cfNBC4uv3kNMsqzqoimFA4P0hBzrScP7tZDugDdtQRaMCIsp83d7eP4aRFgdjTOAkqaY
         EcBySS5OB1Jp1RM9rOIeg4vGNuAodjB8ioNpZliXG5YHvgOI5vg6YkAsh8UlVfEUorgi
         tooZ04Fa4XmOI54vufP3tUNGpQ/vItEuv5AaKv2Kz04lqJiQQJioKi7vXh+7NeFtpPl8
         PrkJ7Fh3n+1xNy+RRz0AlWzBWRZxgnKN90n8tN2vGcjphifpsmzNuElKDbcfnWwdUmZI
         T4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=lQU/mw2gew9Xsu/0BklV7sCPI0gkzm5yQeyxIIbvBKw=;
        b=T93dkarHwpqLAkVCry3uy3/Jy4eYok8XsenvbuB/TOqgcyYxd7pB/7lkMjXY30PkMc
         7UFBNPm5Pm6ew/EkRJzUKmX6cSfCIQsygEoEbXTxvp9eXHVgOkyUmLvwbZXMbvupEI7T
         bJ9DZC70aqSqjI8WgUftBEsd+Ev46lhr4oRsYcXffYtMqRFNaN8gqOWNrt3AGeI2qym4
         LrKHVarN/TVS+IBFaHnql5FBO/Bxo+wlohdYbfvmgcuEeh/BrHr2Z7Tp3YmG0RPbeDsg
         U+e7Zn8r4i3II/0ijKkSKcRvqtRqfG5Dgzt8mdZqCKZetGRSiJTF5AuaoqpZGDz871Lt
         1ZAA==
X-Gm-Message-State: AOAM531kTHTTqsit0BJV+SzzZ3gyydYZSHRaa4HfRXHJBVN0PcHB+2qq
        CvMSFLl70624/qjB55ZlVb+t8w==
X-Google-Smtp-Source: ABdhPJxAQ+fotSqwe8faCf5H7a8xb5y1avK/VcXmLBYp/UuZVxScgxz1HlQG03JVDuAyVp0hpf2MdQ==
X-Received: by 2002:a05:6a00:882:b029:2de:b01d:755a with SMTP id q2-20020a056a000882b02902deb01d755amr32457813pfj.43.1621982884571;
        Tue, 25 May 2021 15:48:04 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id n30sm15459221pgd.8.2021.05.25.15.48.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 May 2021 15:48:03 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <59253C17-3155-4ADF-B965-CEA375230483@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_47C6E327-64C0-41DB-8EFA-2AED6EDE9B5E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: How capacious and well-indexed are ext4, xfs and btrfs
 directories?
Date:   Tue, 25 May 2021 16:48:01 -0600
In-Reply-To: <YK1rebI5vZKCeLlp@casper.infradead.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        David Howells <dhowells@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-cachefs@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
References: <206078.1621264018@warthog.procyon.org.uk>
 <6E4DE257-4220-4B5B-B3D0-B67C7BC69BB5@dilger.ca> <YKntRtEUoxTEFBOM@localhost>
 <B70B57ED-6F11-45CC-B99F-86BBDE36ACA4@dilger.ca>
 <YK1rebI5vZKCeLlp@casper.infradead.org>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--Apple-Mail=_47C6E327-64C0-41DB-8EFA-2AED6EDE9B5E
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On May 25, 2021, at 3:26 PM, Matthew Wilcox <willy@infradead.org> wrote:
> 
> On Tue, May 25, 2021 at 03:13:52PM -0600, Andreas Dilger wrote:
>> Definitely "-o discard" is known to have a measurable performance impact,
>> simply because it ends up sending a lot more requests to the block device,
>> and those requests can be slow/block the queue, depending on underlying
>> storage behavior.
>> 
>> There was a patch pushed recently that targets "-o discard" performance:
>> https://patchwork.ozlabs.org/project/linux-ext4/list/?series=244091
>> that needs a bit more work, but may be worthwhile to test if it improves
>> your workload, and help put some weight behind landing it?
> 
> This all seems very complicated.  I have chosen with my current laptop
> to "short stroke" the drive.  That is, I discarded the entire bdev,
> then partitioned it roughly in half.  The second half has never seen
> any writes.  This effectively achieves the purpose of TRIM/discard;
> there are a lot of unused LBAs, so the underlying flash translation layer
> always has plenty of spare space when it needs to empty an erase block.
> 
> Since the steady state of hard drives is full, I have to type 'make clean'
> in my build trees more often than otherwise and remember to delete iso
> images after i've had them lying around for a year, but I'd rather clean
> up a little more often than get these weird performance glitches.
> 
> And if I really do need half a terabyte of space temporarily, I can
> always choose to use the fallow range for a while, then discard it again.

Sure, that's one solution for a 1TB laptop, but not large filesystems
that may be hundreds of TB per device.  I don't think the owners of
Perlmutter (https://www.nersc.gov/systems/perlmutter/) could be convinced
to avoid using 17PB of their flash to avoid the need for TRIM to work. :-)

Cheers, Andreas






--Apple-Mail=_47C6E327-64C0-41DB-8EFA-2AED6EDE9B5E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmCtfqEACgkQcqXauRfM
H+Dr7RAAv/S5K9b+d4nIh2CHohXKTdMiaX/wu1fLb671uTS1hPABVL+GTVxJlMnQ
J9zXWz0qOxR3XpjlaoaaDd4bp8sOvdiNyKCVspYt3dA2+70OXY0b3NCNoETx/xC+
MI8Bfe9nOvPd5mNq9RYLL1TmlLlEdYPkEgqQhlFSd2j5YFbTx91KQyIlGpmYJozy
wyQsEDLx68e/m8mVl4uDgycqVaR7ECzxDqntELWDD94pR9lecScZszOirZUdRWfy
o9/QuHI0GRsGH1ttenK00MvV2mtiHR4cB891nx63lrOKrQ6xW5dvu0/xGvWqtHUw
CGeWDC/ROL8cN1tAmD22z9cs+lgopez/ISysUW6GxhZn2z65vTw66ooBymT1PTHE
J3ZDVtnBW9lRDeCpAY0mTEvTc9OesBc8YiEB+Tz3XQnIk2eEKCvVWbio8OR+mPWs
32GVJHVc+jZDVUxDuV5HdWjErLndLIkfgylEZm0BHz6+se/beBTvfgZsY60o1VvL
sZGrITkdaGbTwb+FlQnNZd2Nj7/t1BqWm8uIYrORjGJshsct3N8lXH5MmBJlwenA
wezCKjE5kjCUjhVkpd31lSZQM/Jjycm1SWFt/YyZaiNA7C6MvvqzV327hvDUTwt7
LOMQ8MOtgO2/cRKta6uMOOmYnDaR9U07t8W/taStu+i8mvVvwVk=
=SSE/
-----END PGP SIGNATURE-----

--Apple-Mail=_47C6E327-64C0-41DB-8EFA-2AED6EDE9B5E--

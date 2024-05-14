Return-Path: <linux-btrfs+bounces-4962-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2FD8C4EDF
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 12:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6D11C20D47
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 10:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC8C12EBDC;
	Tue, 14 May 2024 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="lOZTURrz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DE912EBC5
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715679239; cv=none; b=PvGA4LflRLqRLrjhT+VhKgiYRVBJ7+77R1GNXZLiCBNPjDE/1O6adciIExGGchqMq8VhInu4Jc5DEMjPnOW4fyKHIXIJGGucRh7h4JAGxwy0pLVr1NBWW1MmJ6cjO4NKiyvXO6VrLzWoFlORFWvFSkwu9u686AQJnlCFu4/8D6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715679239; c=relaxed/simple;
	bh=in1uDsM8tGqtY/DIONaVLP+JrMRARt9A/MLeh0Y8zUs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4rWUDLToAvLuYcNVOcN7ujkk3btieGUfkmtUuSB1MFb8UUxfAvpm53du0HoaPh0/iMXhPjSSQVbNepW80Ryb4kvJl5uuaUooQbuKQKXKwzMuF/I+Ix8w9fmuH+hHU97pPVsvHPOqWvvwMii/G3boOBjB7INY3okS7c6INJAaoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=lOZTURrz; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id 962046016F
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 11:33:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date; s=dkim; i=
	@rus.uni-stuttgart.de; t=1715679223; x=1717418024; bh=in1uDsM8tG
	qtY/DIONaVLP+JrMRARt9A/MLeh0Y8zUs=; b=lOZTURrzN/4M+LDo3NKsF0syfh
	kRTyAeh+BJgzDHs42r+3SJHAyCzVrAaz3JGm85IRnLiMEUZYy13DLtpZEF69rYv9
	njBeNlQMvxP7Vzb/EgmOBDuRWxKzUKpVZM5p1Ods0UnRs1HgWfguryVdst+ufFXr
	mMZkarE+QV+8D4K0UZtQ8a2EexiNxgl5Pcr6xVdLpl/N4KH4JihBgUinw1+61hIT
	GoJociwRWGOdHlC241kb66EA1jYqop3gD+puDgR7U+NVyR6KcRpV13sNTcE1qy+u
	4X8gTWRanpBgVaENhcS8lCrjMFsueI2FHaG07tfZobdCVQh0OYV82LnQPf2g==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id jxKqhp39rBIy for <linux-btrfs@vger.kernel.org>;
 Tue, 14 May 2024 11:33:43 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Tue, 14 May 2024 11:33:43 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: Re: list all subvolumes below given path?
Message-ID: <20240514093343.GB110925@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20240514072238.GA110925@tik.uni-stuttgart.de>
 <CAA91j0XJcCw3+p_owtwA8FWj3A=e5jWHyoLbF1s_ZC1-xKW=Bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA91j0XJcCw3+p_owtwA8FWj3A=e5jWHyoLbF1s_ZC1-xKW=Bw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20230822

On Tue 2024-05-14 (11:11), Andrei Borzenkov wrote:

> > I need to know all subvolumes below a given path.
> 
> That is rather vague.
> 
> Any number of different btrfs filesystems can be mounted below any
> given path. You conflate "mount point" with "btrfs path". Can you
> describe more precisely what you mean?

Sorry to be unprecise.
I mean all subvolumes of the given btrfs filsystem, but excluding other
filsystems (mount points).

In my example: I want to list all subvolmes of the /local filesystem below
$PWD:

root@fex:/local/test# mount | grep /local
/dev/sde1 on /local type btrfs (rw,relatime,space_cache,user_subvol_rm_allowed,subvolid=5,subvol=/)

find does not help me, because it also lists subvolumes of other file
systems which may be mounted below (not there in my example) and option
-xdev excludes subvolumes:

root@fex:/local/test# find . -inum 256 
.
./sv1
./sv1/sv1_1
./sv1/sv1_1/ss
./sv1/sv1_2
./sv2

root@fex:/local/test# find . -xdev -inum 256
.
./sv1
./sv2



> You parse the current mount table to find out what subvolume contains
> $PWD. But again - you may have arbitrary subvolumes from the same and
> different filesystems mounted anywhere below $PWD and you only can
> find it out by parsing the current mount table.

This was my apprehension :-}


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<CAA91j0XJcCw3+p_owtwA8FWj3A=e5jWHyoLbF1s_ZC1-xKW=Bw@mail.gmail.com>


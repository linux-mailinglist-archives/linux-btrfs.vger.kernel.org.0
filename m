Return-Path: <linux-btrfs+bounces-64-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE3D7E6C96
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Nov 2023 15:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273E61C20A39
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Nov 2023 14:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E95A1BDC5;
	Thu,  9 Nov 2023 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fmy7kQgW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AcBXCHHb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD1220E6
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Nov 2023 14:45:36 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A58B3588
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Nov 2023 06:45:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0A1921992;
	Thu,  9 Nov 2023 14:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699541133;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qqv+bXkRdrVZ0334SQQIY/R3RpTGTpa1m3NoUl7qquk=;
	b=Fmy7kQgWcKoyXf8jhtrBcaChaOdCXoAl3OeNxQNH56KGTa4s/FqCIB3DrbMLmaJO8Im1Qx
	DlWEc9qpBDqdWPBzPlaiXnDVzWfIG3RCZhkrw5gQyTud8tmVLV/2CyxdeLBXglM2pI4JM2
	TMBdVkgP44qv9jBYTktp1fAauFCLYPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699541133;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qqv+bXkRdrVZ0334SQQIY/R3RpTGTpa1m3NoUl7qquk=;
	b=AcBXCHHbJS9U5TrY3P66VSMTHtpSz250sF1al/o43KO9728YSPSM/DgkvByQ8ZxtlzU32b
	OBNPsbfJpW+NN4Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A200138E5;
	Thu,  9 Nov 2023 14:45:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id zdPqJI3wTGVGdgAAMHmgww
	(envelope-from <dsterba@suse.cz>); Thu, 09 Nov 2023 14:45:33 +0000
Date: Thu, 9 Nov 2023 15:38:30 +0100
From: David Sterba <dsterba@suse.cz>
To: Joe Salmeri <jmscdba@gmail.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: Btrfs progs release 6.6.1
Message-ID: <20231109143830.GT11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231105222046.19483-1-dsterba@suse.com>
 <aa605999-708c-4b8c-a05c-78fd2cc6b5b2@gmail.com>
 <be0c51ba-86bd-44e7-884a-6cfccfa76184@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be0c51ba-86bd-44e7-884a-6cfccfa76184@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)

On Sun, Nov 05, 2023 at 06:40:45PM -0500, Joe Salmeri wrote:
> Is there a way for btrfs to remove that directory entry which points to 
> the inode that does not exist ?
> 
> After I removed all the @home snapshots, that got rid of all of them 
> items that btrfs check reports EXCEPT for the one in the @home subvolume 
> so deleting a subvolume can remove the items, but I really don't want to 
> have to delete and restore the @home subvolume to fix it.
> 
> And since then btrfs has created new timeline snapshots for @home so 
> those obviously have the same issue as the ones I deleted but that 
> problem would go away if I can find a way to remove the offending item 
> in the @home subvolume.
> 
> Is there some way to remove that item ?
> 
> Running "ls -al /home/denise/.config/skypeforlinux/blob_storage/" also 
> shows that offending item:
> 
>      drwx------ 1 denise joe-denise   72 Nov  1 22:49 .
>      drwxr-xr-x 1 denise joe-denise 3.7K Nov  1 20:07 ..
>      d????????? ? ?      ?             ?            ? 02179466-b671-4313-8fa5-0eb87d716f92
> 
> I tried removing /home/denise/.config/skypeforlinux/blob_storage/ since 
> that is the folder that contains the 
> i02179466-b671-4313-8fa5-0eb87d716f92 directory item but that fails
> 
>      rm -rf /home/denise/.config/skypeforlinux/blob_storage/
> /usr/bin/rm: cannot remove 
> '/home/denise/.config/skypeforlinux/blob_storage/': Directory not empty

On a mounted filesystem this is not possible, also I'm not sure what
exactly is the problem there. It looks like the directory entry is valid
(thus it shows the file name) but the pointer to the inode is either
damaged (cosmic rays) or the inode is gone for some reason.

The 'btrfs check' should be able to guess what's the extent of the
dirent/inode desynchronization and remove the entry eventually, but as
always 'check + repair' should be used with care and when absolutely
sure that it's not making the things worse. Some cross checks could be
possible, e.g. look up the relevant data in the tree dump.


Return-Path: <linux-btrfs+bounces-1400-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A50D82B3AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 18:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE16B24ED9
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 17:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C250D51C44;
	Thu, 11 Jan 2024 17:07:03 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB405100A;
	Thu, 11 Jan 2024 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE184221E2;
	Thu, 11 Jan 2024 17:06:59 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A1139132FA;
	Thu, 11 Jan 2024 17:06:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id aj/0JTMgoGVzCQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 11 Jan 2024 17:06:59 +0000
Date: Thu, 11 Jan 2024 18:06:44 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Anand Jain <anand.jain@oracle.com>,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-kernel@vger.kernel.org, Alex Romosan <aromosan@gmail.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: [btrfs] commit bc27d6f0aa0e4de184b617aceeaf25818cc646de breaks
 update-grub
Message-ID: <20240111170644.GK31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com>
 <39e3a4fe-d456-4de4-b481-51aabfa02b8d@leemhuis.info>
 <20240111155056.GG31555@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111155056.GG31555@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DE184221E2
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Jan 11, 2024 at 04:50:56PM +0100, David Sterba wrote:
> On Thu, Jan 11, 2024 at 12:45:50PM +0100, Thorsten Leemhuis wrote:
> > [Adding Anand Jain, the author of the culprit to the list of recipients;
> > furthermore CCing the the Btrfs maintainers and the btrfs list; also
> > CCing regression list, as it should be in the loop for regressions:
> > https://docs.kernel.org/admin-guide/reporting-regressions.html]
> > 
> > On 08.01.24 15:11, Alex Romosan wrote:
> > > Please Cc me as I am not subscribed to the list.
> > > 
> > > Running my own compiled kernel without initramfs on a lenovo thinkpad
> > > x1 carbon gen 7.
> > > 
> > > Since version 6.7-rc1 i haven't been able to to a grub-update,
> > >
> > > instead i get this error:
> > > 
> > > grub-probe: error: cannot find a device for / (is /dev mounted?) solid
> > > state drive
> > > 
> > > 6.6 was the last version that worked.
> > > 
> > > Today I did a git-bisect between these two versions which identified
> > > commit bc27d6f0aa0e4de184b617aceeaf25818cc646de btrfs: scan but don't
> > > register device on single device filesystem as the culprit. reverting
> > > this commit from 6.7 final allowed me to run update-grub again.
> > > 
> > > not sure if this is the intended behavior or if i'm missing some other
> > > kernel options. any help/fixes would be appreciated.
> > > 
> > > thank you.
> > 
> > Thanks for the report. To be sure the issue doesn't fall through the
> > cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> > tracking bot:
> > 
> > #regzbot ^introduced bc27d6f0aa0e4de184b617aceeaf25818cc646de
> > #regzbot title btrfs: update-grub broken (cannot find a device for / (is
> > /dev mounted?))
> > #regzbot ignore-activity
> 
> The bug is also tracked at https://bugzilla.kernel.org/show_bug.cgi?id=218353 .

About the fix: we can't simply revert the patch because the temp_fsid
depends on that. A workaround could be to check if the device path is
"/dev/root" and still register the device. But I'm not sure if this does
not break the use case that Steamdeck needs, as it's for the root
partition.


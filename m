Return-Path: <linux-btrfs+bounces-1392-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34A882ADBE
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 12:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BA71F2444C
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 11:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D626154AA;
	Thu, 11 Jan 2024 11:46:03 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADDC14F9D;
	Thu, 11 Jan 2024 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rNtVP-0007Bi-K4; Thu, 11 Jan 2024 12:45:51 +0100
Message-ID: <39e3a4fe-d456-4de4-b481-51aabfa02b8d@leemhuis.info>
Date: Thu, 11 Jan 2024 12:45:50 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [btrfs] commit bc27d6f0aa0e4de184b617aceeaf25818cc646de breaks
 update-grub
Content-Language: en-US, de-DE
To: Anand Jain <anand.jain@oracle.com>
References: <CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 linux-kernel@vger.kernel.org, Alex Romosan <aromosan@gmail.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>
In-Reply-To: <CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1704973561;f3cf3eb7;
X-HE-SMSGID: 1rNtVP-0007Bi-K4

[Adding Anand Jain, the author of the culprit to the list of recipients;
furthermore CCing the the Btrfs maintainers and the btrfs list; also
CCing regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 08.01.24 15:11, Alex Romosan wrote:
> Please Cc me as I am not subscribed to the list.
> 
> Running my own compiled kernel without initramfs on a lenovo thinkpad
> x1 carbon gen 7.
> 
> Since version 6.7-rc1 i haven't been able to to a grub-update,
>
> instead i get this error:
> 
> grub-probe: error: cannot find a device for / (is /dev mounted?) solid
> state drive
> 
> 6.6 was the last version that worked.
> 
> Today I did a git-bisect between these two versions which identified
> commit bc27d6f0aa0e4de184b617aceeaf25818cc646de btrfs: scan but don't
> register device on single device filesystem as the culprit. reverting
> this commit from 6.7 final allowed me to run update-grub again.
> 
> not sure if this is the intended behavior or if i'm missing some other
> kernel options. any help/fixes would be appreciated.
> 
> thank you.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced bc27d6f0aa0e4de184b617aceeaf25818cc646de
#regzbot title btrfs: update-grub broken (cannot find a device for / (is
/dev mounted?))
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


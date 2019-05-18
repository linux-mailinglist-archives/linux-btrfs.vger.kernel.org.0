Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F7E2229D
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2019 11:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfERJWQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 18 May 2019 05:22:16 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.28]:14467 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfERJWQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 May 2019 05:22:16 -0400
Received: from [94.217.151.102] (helo=[192.168.177.20])
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <hendrik@friedels.name>)
        id 1hRvXg-0007xY-Lf; Sat, 18 May 2019 11:22:12 +0200
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Hendrik Friedel" <hendrik@friedels.name>,
        "samba@lists.samba.org" <samba@lists.samba.org>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: [Samba] Fw: Btrfs Samba and Quotas
Date:   Sat, 18 May 2019 09:22:10 +0000
Message-Id: <em20253d9b-ed68-47a7-946b-55c040417fd6@ryzen>
In-Reply-To: <emee6c041c-adec-4106-b8f6-c4665299ea29@ryzen>
References: <emee6c041c-adec-4106-b8f6-c4665299ea29@ryzen>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/7.2.34062.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: aGVuZHJpa0BmcmllZGVscy5uYW1l
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I a bit surprised to get no replies at all...
How come? Lack of information? Lack of clarity?

Greetings,
Hendrik


------ Originalnachricht ------
Von: "Hendrik Friedel via samba" <samba@lists.samba.org>
An: "samba@lists.samba.org" <samba@lists.samba.org>
Gesendet: 14.05.2019 20:01:41
Betreff: [Samba] Fw: Btrfs Samba and Quotas

>Hello,
>
>by suggestion from linux-btrfs I post this to samba@lists.samba.org.
>I think, thiss is a bug in Samba. Can you confirm and suggest a workaround?
>
>Regards,
>Hendrik
>
>------ Weitergeleitete Nachricht ------
>Von: "Hendrik Friedel" <hendrik@friedels.name>
>An: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
>Gesendet: 12.05.2019 13:27:00
>Betreff: Btrfs Samba and Quotas
>
>Hello,
>
>I was wondering, whether anyone of you has experience with this samba in conjunction with BTRFS and quotas.
>
>I am using Openmediavault (debian based NAS distribution), which is not actively supporting btrfs. It uses quotas by default, and I think, that me using btrfs is causing troubles...
>
>In the logs I find:
>May 12 09:34:06 homeserver smbd[4116]:   sys_path_to_bdev() failed for path [.]!
>May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.879166,  0] ../source3/lib/sysquotas.c:461(sys_get_quota)
>May 12 09:34:06 homeserver smbd[4116]:   sys_path_to_bdev() failed for path [.]!
>May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.879356,  0] ../source3/lib/sysquotas.c:461(sys_get_quota)
>May 12 09:34:06 homeserver smbd[4116]:   sys_path_to_bdev() failed for path [.]!
>May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.879688,  0] ../source3/lib/sysquotas.c:461(sys_get_quota)
>May 12 09:34:06 homeserver smbd[4116]:   sys_path_to_bdev() failed for path [Hendrik]!
>May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.879888,  0] ../source3/lib/sysquotas.c:461(sys_get_quota)
>May 12 09:34:06 homeserver smbd[4116]:   sys_path_to_bdev() failed for path [Hendrik]!
>May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.880093,  0] ../source3/lib/sysquotas.c:461(sys_get_quota)
>May 12 09:34:06 homeserver smbd[4116]:   sys_path_to_bdev() failed for path [Hendrik]!
>May 12 09:34:06 homeserver smbd[4116]: [2019/05/12 09:34:06.880287,  0] ../source3/lib/sysquotas.c:461(sys_get_quota)
>May 12 09:34:06 homeserver smbd[4116]:   sys_path_to_bdev() failed for path [Hendrik]!
>
>As you can see, this is quite frequent.
>
>Searching for this, I find some bug-reports:
>https://bugs.launchpad.net/ubuntu/+source/samba/+bug/1735953
>https://bugzilla.samba.org/show_bug.cgi?id=10541
>
>Now, I am sure that I am not the first to use Samba with btrfs. What's special about me? How's your experience?
>
>Greetings,
>Hendrik
>
>
>-- To unsubscribe from this list go to the following URL and read the
>instructions:  https://lists.samba.org/mailman/options/samba


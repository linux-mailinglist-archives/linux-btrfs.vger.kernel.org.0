Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E78CC13575F
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 11:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgAIKth (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 05:49:37 -0500
Received: from pme1.philip-seeger.de ([194.59.205.51]:43156 "EHLO
        pme1.philip-seeger.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbgAIKth (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jan 2020 05:49:37 -0500
Received: from webmail.philip-seeger.de (pme1.philip-seeger.de [IPv6:2a03:4000:34:141::100])
        by pme1.philip-seeger.de (Postfix) with ESMTPSA id 90C6A1FC92D;
        Thu,  9 Jan 2020 11:49:35 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 09 Jan 2020 11:49:35 +0100
From:   Philip Seeger <philip@philip-seeger.de>
To:     Chris Murphy <lists@colorremedies.com>, linux-btrfs@vger.kernel.org
Subject: Re: Monitoring not working as "dev stats" returns 0 after read error
 occurred
In-Reply-To: <CAJCQCtQ-+h36QgOk5ZohLdNwEhzWwqpU=ZjsGXnDLNAPTmwv1w@mail.gmail.com>
References: <3283de40c2750cd62d020ed71430cd35@philip-seeger.de>
 <CAJCQCtQ-+h36QgOk5ZohLdNwEhzWwqpU=ZjsGXnDLNAPTmwv1w@mail.gmail.com>
Message-ID: <938be4dc21140fc54a0f318ab26c3d9d@philip-seeger.de>
X-Sender: philip@philip-seeger.de
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-01-08 22:47, Chris Murphy wrote:
> Unrelated to your report, but you need to update your kernel. The one
> you're using has a pernicious bug that can result in unrepairable
> corruption of the file system. Use 5.2.15 or newer.
> 
> https://lore.kernel.org/linux-btrfs/20190725082729.14109-3-nborisov@suse.com/

Chris, thank you very much! I appreciate it (not the pernicious bug but 
the heads-up).

I was going to do that anyway very soon.

I guess those who're not always up-to-date with their kernel are living 
dangerous lives...
(I just realized that I still wouldn't know about that bad drive, had I 
upgraded or rebooted earlier.)

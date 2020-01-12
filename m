Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEEB138875
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Jan 2020 23:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387448AbgALWpV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jan 2020 17:45:21 -0500
Received: from pme1.philip-seeger.de ([194.59.205.51]:33436 "EHLO
        pme1.philip-seeger.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgALWpV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jan 2020 17:45:21 -0500
Received: from [192.168.10.139] (ppp-93-104-101-141.dynamic.mnet-online.de [93.104.101.141])
        by pme1.philip-seeger.de (Postfix) with ESMTPSA id 970BB200A76;
        Sun, 12 Jan 2020 23:45:19 +0100 (CET)
Subject: Re: Monitoring not working as "dev stats" returns 0 after read error
 occurred
To:     linux-btrfs@vger.kernel.org
References: <3283de40c2750cd62d020ed71430cd35@philip-seeger.de>
 <d89fe4da-c498-bb24-8eb5-a19b01680a23@cobb.uk.net>
 <ac61f79a3c373f319232640db5db9a5e@philip-seeger.de>
 <2a9bf923-e7b9-9d82-5f1d-bbdfc192978e@suse.com>
 <d3a234a07192fd9713b0ac33123c99db@philip-seeger.de>
 <68ebf136-6aff-bd98-cf95-0c3c7d5bed89@philip-seeger.de>
 <9b6d7519-cffb-2cfa-5e77-b514817b5f0a@gmail.com>
 <2ddeb325-7c53-5423-8b14-8393c6928350@philip-seeger.de>
 <01a333c2-b3fc-128c-073a-d7b4d455f13c@dirtcellar.net>
Cc:     waxhead@dirtcellar.net
From:   Philip Seeger <philip@philip-seeger.de>
Message-ID: <3f569247-f852-b792-d176-470686b3c2bf@philip-seeger.de>
Date:   Sun, 12 Jan 2020 23:45:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <01a333c2-b3fc-128c-073a-d7b4d455f13c@dirtcellar.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/12/20 6:39 PM, waxhead wrote:
> Speaking of... it would be great if btrfs device stats /mnt (or some 
> other command) could offer to show a list of corrupted files with paths 
> (which I assume the filesystem know about). That would make restoring 
> files from backup a breeze!

*cough* zfs status -v *cough*


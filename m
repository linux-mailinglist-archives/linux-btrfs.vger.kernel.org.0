Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6072B22A1AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jul 2020 00:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgGVWA2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 18:00:28 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:54243 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgGVWA2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 18:00:28 -0400
Received: from host86-157-100-178.range86-157.btcentralplus.com ([86.157.100.178] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jyMmo-0005ti-4V; Wed, 22 Jul 2020 23:00:26 +0100
Subject: Re: Linux RAID with btrfs stuck and consume 100 % CPU
To:     Vojtech Myslivec <vojtech@xmyslivec.cz>,
        linux-btrfs@vger.kernel.org, linux-raid@vger.kernel.org
Cc:     Michal Moravec <michal.moravec@logicworks.cz>
References: <d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <0f935586-7d2f-02b9-9955-ab160dd4017f@youngman.org.uk>
Date:   Wed, 22 Jul 2020 23:00:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/07/2020 21:47, Vojtech Myslivec wrote:
> - RAID6 over 6 HDD and 1 LV as write journal (md1)
>      - This is the affected device

What hard drives do you have?

https://raid.wiki.kernel.org/index.php/Timeout_Mismatch

Dunno whether that is your problem, but it's one of the first things to 
check.

Cheers,
Wol

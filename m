Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E989710F35E
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 00:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbfLBX1u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 18:27:50 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:43111 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfLBX1u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 18:27:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds201810; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+fEuokqGDSQW4L3cFNAiDrH+7vvj7sA2DzLZUB7ylxc=; b=pclLNFDbhaZR/6JLZpQI2iWeKb
        m0IOacHOqYatp8Zj9AjmDujM9H36n7exa8oQIQ4ksGY2c6ZKH2ulxjMvPUeCdiU35lwZmFscLpIyv
        2100ilWoMfLe5aS3iaInyTRkVsU8ET7sAofCMOY5tKRn02wjmq5/WQ6iWICiDQiy3zXxgMYQH3STE
        rryQFaANN/6EjncGhkTXbC6d/NurgPrcU9RRvNxaIKTHto6Yi/0cKRhyvaL5FC5jm23vN6hoptGxG
        KFzw3jw5B26jW82lPKhhmH3VWYyt/srJcE1PO5PVd/W8tRONGKd2MCJKdluPCSmHhuTlO4Ir9MrY4
        Ib0siURA==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:42175 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1ibv6a-0005f0-38; Tue, 03 Dec 2019 00:27:48 +0100
Reply-To: waxhead@dirtcellar.net
Subject: Re: BTRFS subvolume RAID level
To:     Anand Jain <anand.jain@oracle.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <494b0df1-2aab-5169-836d-e381498f64db@dirtcellar.net>
 <ed65c577-3971-8c4f-c690-83e85dd8188e@oracle.com>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <fcbe2d91-a6ad-5b9b-fa66-aebb2edd14f1@dirtcellar.net>
Date:   Tue, 3 Dec 2019 00:27:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.5
MIME-Version: 1.0
In-Reply-To: <ed65c577-3971-8c4f-c690-83e85dd8188e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Anand Jain wrote:
> 
>> I imagine that RAIDc4 for example could potentially give a grotesque 
>> speed increase for parallel read operations once BTRFS learns to 
>> distribute reads to the device with the least waitqueue / fastest 
>> devices.
> 
>   That exactly was the objective of the Readmirror patch in the ML.
>   It proposed a framework to change the readmirror policy as needed.
> 
> Thanks, Anand

Indeed. If I remember correctly your patch allowed for deterministic 
reading from certain devices. As just a regular btrfs user the problem I 
see with this is that you loose a "potential free scrub" that *might* 
otherwise happen from often read data. On the other hand that is what 
manual scrubbing is for anyway.



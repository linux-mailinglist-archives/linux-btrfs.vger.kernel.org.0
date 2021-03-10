Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF1833328D
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 01:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhCJAo7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Mar 2021 19:44:59 -0500
Received: from krystal1.wisercloud.co.uk ([185.53.58.188]:45192 "EHLO
        krystal1.wisercloud.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhCJAom (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Mar 2021 19:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=petezilla.co.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yq4QUcFnlJgieGgVJDiFDlueNk/HTJZsHsNsfihjDx4=; b=TlU8eZtSuhIXYlETXedzdkPb1d
        YCboHuV4tLhwnxbiKvVqlABZgv9UCGCejKcdp+aLI6neuQTfs2MGj93ou+o/+bI4/yPqXTFYShgQu
        zygA2/+m6HYdtPFz6RYBkQxovPmWM+7HQKC+Al6MLO1OaAVg+jsCsLFuCU7n5RU7JMk4BdhSYQG9e
        LeMY98krNRfyXUIunaR8f/3VrmJG2TCKmYgAXd1AwrX/yC2Hh6TbqlovTx9441uonLrOp5Jyi+ZPn
        USJZp/nblc/+EnaZERNVzKX0V6da02nJ94tDGI7fmIC4ukZsp+LPehmhU3HGZADryCDoZym8yBbCE
        TFSEw0Kg==;
Received: from cpc75872-ando7-2-0-cust919.15-1.cable.virginm.net ([86.13.79.152]:57598 helo=phoenix.exfire)
        by krystal1.wisercloud.co.uk with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <pete@petezilla.co.uk>)
        id 1lJmxs-00H7Ga-V2; Wed, 10 Mar 2021 00:44:41 +0000
Subject: Re: Cannot add a device to a btrfs, btrfs on lvm and dm-crypt / luks
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <99a86fc6-2931-c969-f46a-c04f819d2b4d@petezilla.co.uk>
 <5fd10caa-fab8-4e5d-d9bc-2339589b1b8f@gmx.com>
From:   Pete <pete@petezilla.co.uk>
Message-ID: <d64319c9-d2c0-d640-3f3a-7697cc170647@petezilla.co.uk>
Date:   Wed, 10 Mar 2021 00:44:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <5fd10caa-fab8-4e5d-d9bc-2339589b1b8f@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-0.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - krystal1.wisercloud.co.uk
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - petezilla.co.uk
X-Get-Message-Sender-Via: krystal1.wisercloud.co.uk: authenticated_id: pete+petezilla.co.uk/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: krystal1.wisercloud.co.uk: pete@petezilla.co.uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu,
thanks, much appreciated.  I'd missed that.  Good, an easy fix.


>> Kernel 5.10.19
>> btrfs-progs 5.10.1
>
> It's a known regression in v5.10.1 btrfs-progs, which did wrong path
> normalization for device map.
>
> It's fixed in v5.11 btrfs-progs.
>
> Thanks,
> Qu


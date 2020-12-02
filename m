Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823FF2CCABA
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 00:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgLBXxM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 18:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgLBXxM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 18:53:12 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB47C0613D6
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 15:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds201912; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Reply-To:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WoXhBYpJt/Ix+Fg7wUqGDDkcY5/Nuh81iBDDfZC29N8=; b=QWJwCzQTfYy8LhRMc8UzyklnKU
        ducgaeioj2FuBd7ErqozmCWxdBnjgeg5FMIPD6C/o/JKLewm/QDcqUh35EoLteFj7W1PbFVq7Xzue
        AjDNj3wrfgCSG1Tilo8r+KYoAJle6ZC3KyOykvi8lcu4DyvmClfQjJMO79ps2KvdW9rxqLeciXfp7
        2uOQAC0j3CUWnhEfO9eK8phEdPCrq2SZlBMhvTjtJ3QVswQj55mqWftlKgBm4TMryGJ7uN9G6H+WD
        gH8DojgdApimPCKid/pMg1AAnot9BFgQt5D2AF+GTrM9sFHQgTczETiH3ltNxsgT6eiaG9l5ctahk
        jWHocD/w==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:53770 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1kkbup-0005YL-3q
        for linux-btrfs@vger.kernel.org; Thu, 03 Dec 2020 00:52:07 +0100
Reply-To: waxhead@dirtcellar.net
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   waxhead <waxhead@dirtcellar.net>
Subject: Per. subvolume RAID levels removed from planned features?
Message-ID: <e1b4808c-c057-e879-ef6e-33cdedcd3df1@dirtcellar.net>
Date:   Thu, 3 Dec 2020 00:52:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I noticed that object level mirroring and striping was removed from the 
wikis list of 'features currently in development or planned for future 
releases.'

Does this mean that per. subvolume RAID levels are a lost cause?

I earlier suggest that I think that it should be possible to assign 
storage device ID's to groups. For example group1=fast_hdd, 
group2=fast_ssd, group3=slow_hdd, etc.... etc....

While admittedly per. subvolume RAID levels would be mostly useful if 
you could assign weight to a subvolume to make it prefer to be stored on 
a certain group or groups I still think that for some setups per. 
subvolume RAID levels still serves a purpose and I would hate to see 
that feature go.

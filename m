Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9DCAF3B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 02:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfIKAhD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 20:37:03 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:54119 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725916AbfIKAhD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 20:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:Reply-to:In-Reply-To:References:
        Subject:To:From:Message-ID:Date:Sender:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eSAVtcojUqWKRcpIu/ZHTz5DAj+QWFNFSuvIx1llWOQ=; b=BU6rKee4Xz+A/mlZkXdbP+TjFw
        xbl/c3GBaCE78S0MO5kji7ELth6zybZT6fgq6wnobo5b8ED9hVZUsQQ5lfoSFSTYtJETxYFviZSBV
        eH0q/zjDzbTtW5c4/zsseyO7iP1+3Ey+jVTa5Ztf1dKCiUvIkkwsEVtd217EmSYsyaReklgO7U0ZQ
        cAUpVVe3srxr2WRXoP8swOw99UmZa3f9N0USl0t5SaNizAL0gjvtxUmjR+Q9486aKhqX5YIoL1mSH
        jCl7er9e0uoGOoADg7lrRNy2Tpplma/9UxnR5WapCyeI4wHhoq5qi1oqheyXUgQTGGbXR/+9JWCDG
        ZT60mspw==;
Received: from [::1] (port=55836 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <webmaster@zedlx.com>)
        id 1i7qcz-003iEF-V1; Tue, 10 Sep 2019 20:37:02 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Tue, 10 Sep 2019 20:36:57 -0400
Date:   Tue, 10 Sep 2019 20:36:57 -0400
Message-ID: <20190910203657.Horde.zTdRayLJQht6MGO0gyFV2wX@server53.web-hosting.com>
From:   webmaster@zedlx.com
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <20190909123818.Horde.dbl-yi_cNi8aKDaW_QYXVij@server53.web-hosting.com>
 <ba5f9d6c-aa6c-c9b2-76d2-3ca56606fcc5@gmx.com>
 <20190909200638.Horde.GlzWP3_SqKPkxpAfp05Rsz7@server53.web-hosting.com>
 <3666d54b-76f7-9eee-4fb6-36c1dcc37fe9@gmx.com>
 <20190910202637.Horde.sP3Q7-sjETTnnOXgETzjAZX@server53.web-hosting.com>
In-Reply-To: <20190910202637.Horde.sP3Q7-sjETTnnOXgETzjAZX@server53.web-hosting.com>
Reply-to: webmaster@zedlx.com
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server53.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - zedlx.com
X-Get-Message-Sender-Via: server53.web-hosting.com: authenticated_id: zedlryqc/from_h
X-Authenticated-Sender: server53.web-hosting.com: webmaster@zedlx.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I made a small mistake, in 2) replace the word "ONE" with "AT LEAST ONE"

B) "sharing-defrag"
    a file is share-defragmented if ALL of the following are met:
    1) all extents are written on disk in neighbouring sectors in the  
ascending order
    2) all pairs of *adjanced* extents meet AT LEAST ONE of the  
following criteria
       2.1) both extents are sufficiently large
       2.2) the two extents have mismatching sharing groups (they are  
shared by different sets of files)


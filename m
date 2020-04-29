Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C961BE9CF
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Apr 2020 23:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgD2VXq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Apr 2020 17:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2VXp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Apr 2020 17:23:45 -0400
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865A7C03C1AE
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Apr 2020 14:23:45 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jTuBC-00012Q-Ib; Wed, 29 Apr 2020 23:23:42 +0200
Subject: Re: nodatacow questions
To:     Hugo Mills <hugo@carfax.org.uk>, linux-btrfs@vger.kernel.org
References: <f2e0ca56-c059-978a-2d47-73204b22945b@peter-speer.de>
 <20200429183344.GD30508@savella.carfax.org.uk>
 <2eca0956-c45a-7d3f-1d04-b05a35db0722@peter-speer.de>
 <20200429190057.GE30508@savella.carfax.org.uk>
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Message-ID: <a3373eb2-4ffb-9b63-d5e7-85e3c10dcfb1@peter-speer.de>
Date:   Wed, 29 Apr 2020 23:23:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429190057.GE30508@savella.carfax.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1588195425;63716959;
X-HE-SMSGID: 1jTuBC-00012Q-Ib
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.04.20 21:00, Hugo Mills wrote:
>     At least for the VM images, use raw files, not qcow2, and it's
> probably best to not use btrfs inside the image -- you want to reduce
> the number of layers of CoW.

Thanks, Hugo.
These machines are already set up in the way you mentioned and will need 
migration only if the new host is up and running.

Now, after hours of reading, diving and planing a possible btrfs setup I 
am still not sure if using btrfs is the right choice or if I should stay 
with mdadm/luks/lvm/ext4...

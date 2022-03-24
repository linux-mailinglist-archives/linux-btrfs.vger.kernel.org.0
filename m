Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA604E681A
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 18:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243827AbiCXRy4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 13:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiCXRyz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 13:54:55 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DE64D603
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 10:53:21 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 02A5C806B3;
        Thu, 24 Mar 2022 13:53:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1648144401; bh=IfXh6dYhzJkjEbGnXtT/wKWG8vSIox1JDledHVZWuPA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QAZ2aDObptM5Uu5Ej17v+JeLBh36bVhi7neTHOgisSCeS2c40q2rfFsjfTsSntgIF
         xDPwFZYnEEb3TYMW/8AwsOLQFbfra6l1Eho3OqTnMh/B3D+DvGAdO0NNUmvrzAai/R
         uahQMNuO5u+0rYT+54ueCq4as25IsQxrdwBx+AXIDJ/y3CnQ9hsBmlBuEXrKnZ4g0H
         hS6xGvPc+H9mp5dKVqiyeRSekReIR0nW9/RxIAr3jTv4tskhFzXy13r4fn51twGX5w
         8TowVRtUNGQF+h+sqydjE8enKPMKTaWI6Cm/F3yg2zgpZg96o7sfOhnQaKfbXPdPu5
         AR1JVnFzkp2IA==
Message-ID: <fb73fe9a-21a4-0744-2a61-bfd3602a0f20@dorminy.me>
Date:   Thu, 24 Mar 2022 13:53:20 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v14 5/7] btrfs: send: allocate send buffer with
 alloc_page() and vmap() for v2
Content-Language: en-US
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
References: <cover.1647537027.git.osandov@fb.com>
 <4353fe7122eb0aae24e3c9ff2399f2b58b74f79e.1647537027.git.osandov@fb.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <4353fe7122eb0aae24e3c9ff2399f2b58b74f79e.1647537027.git.osandov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,DOS_RCVD_IP_TWICE_B,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/17/22 13:25, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> For encoded writes, we need the raw pages for reading compressed data
> directly via a bio.
Perhaps:
"For encoded writes, the existing btrfs_encoded_read*() functions expect 
a list of raw pages."

I think it would be a better to continue just vmalloc'ing a large 
continuous buffer and translating each page in the buffer into its raw 
page with something like is_vmalloc_addr(data) ? vmalloc_to_page(data) : 
virt_to_page(data). Vmalloc can request a higher-order allocation, which 
probably doesn't matter but might slightly improve memory locality. And 
in terms of readability, I somewhat like the elegance of having a single 
identical kvmalloc call to allocate and send_buf in both cases, even if 
we do need to initialize the page list for some v2 commands.

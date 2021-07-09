Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3ABD3C207A
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 10:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhGIIMg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 04:12:36 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43031 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231278AbhGIIMg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Jul 2021 04:12:36 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 980355C00B5
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 04:09:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 09 Jul 2021 04:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=w
        LY8vVdL/BVP2m5VvkRUHPFvbIVfUbl+52RgwZt+exI=; b=IBf2NO3+jcdVG5Zd/
        Oyzt5UKSToMdRLv77skSA7h9gLl8Q3YmuKQe2R+6Cxs7AhmmtmkxS+JnIcttm4jz
        OtkbvgyBkj/SnjiwVrg7e35kZ2sBrm+TTVmo6QQquwf8u5HqGywCPWn7B5+Q3Z4c
        jzGiAFoMxQiB1CzKvH1rtXcgA9jzHHsoK+1ju01eyAj3buE5iRQlNRsnCfZ9KBZf
        K9XP5Yd0iZfylsnsB1TIBeO0AIuy8FcJr/RMx4w/VmJogEiY8/s7QGSGqIOwHuRP
        MYZTS5PGJD6VwysjmxU6f5mGOGX2uqgP9iEZPgm3rj3QGTlDYgEgstvGlJasXU2+
        natiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=wLY8vVdL/BVP2m5VvkRUHPFvbIVfUbl+52RgwZt+e
        xI=; b=CgVoMxdIfAX520kAkJcBd4VmCj+8+O6eLSEaYo6e4RLbIx4jzJ6oyh5T7
        YwwQbmzkVIg1wultYon9Z/X3zKFqvmL6Xz7IpScZklZz+MZG26VZa5kWuuN/ndAG
        Y79BiJOGTbrkj61vxRHkV7khqq/SN+OE001V0rOqI5g3ApTbNWipvnJK0Ty4DujA
        4rSo/8fSEAzLqyvbgkWA7wxNrs+1WQ36UokVR/cGba7LF/yod9wrzfaiGNFzJksf
        6eTpfk0plJ/qA2L+e05DVhmKhU25P1oRVarajE6waLdhFLbL47BnqDdxFWa3jT2k
        pFcjlfVG+VHUJK/UmQZHDfmhXpVZg==
X-ME-Sender: <xms:UAToYGcqqgGrRJ52YvIlHsOjA91Xi1nlokhCCVo0ANmU_Xf1dIwOkA>
    <xme:UAToYAO0dkim63VtWJgDGV5qERSNyKRJGvCsbZbBtaWb-BZDJKSJPPC_nSHBM6eqa
    rqE3vQLRJfm1MyUgg>
X-ME-Received: <xmr:UAToYHivaQQ0YnZfcype_jjIDCyMiYNGqj1vT2cNtMcY-rfXkbm_ZXDbJbYRJLKDrsPYVpvvw6a6a2o_ToEB2MHm07U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtdehgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtgfesthejre
    dttdefjeenucfhrhhomheptfgvmhhiucfirghuvhhinhcuoehrvghmihesghgvohhrghhi
    rghnihhtrdgtohhmqeenucggtffrrghtthgvrhhnpefhgfefuedttdduhfdujeekjeduve
    eltdduueffhffhueekjeekkeeitdffhfffieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgtohhm
X-ME-Proxy: <xmx:UAToYD_yKOzqolDqVcYcIq5uUW7BxqNxbvVVe6bIHhVe9Px2QMe3-Q>
    <xmx:UAToYCuDa4fufD7XvlMo8CsEMtRb27MfzQaABidhn55YLee6PpySLQ>
    <xmx:UAToYKEXKvc54t2myeAqwDub64MRd8zteK9ChlZVPhGqdJrIJDmMeg>
    <xmx:UAToYD5ETmKSw_fL4YapzdxDib2yJHQNYsimjHs9ar5kryswmIltrg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-btrfs@vger.kernel.org>; Fri, 9 Jul 2021 04:09:52 -0400 (EDT)
Subject: Re: where is the parent of a snapshot?
To:     linux-btrfs@vger.kernel.org
References: <20210708213806.GA8249@tik.uni-stuttgart.de>
 <0f03c92b-f3c6-bab8-fa37-ef1b489e2d38@gmail.com>
 <20210709071555.GD8249@tik.uni-stuttgart.de>
 <20210709072101.GE11526@savella.carfax.org.uk>
 <20210709073731.GB582@tik.uni-stuttgart.de>
 <20210709074810.GA1548@tik.uni-stuttgart.de>
From:   Remi Gauvin <remi@georgianit.com>
Message-ID: <eb210591-3d91-72c3-783f-ccedb9ef3359@georgianit.com>
Date:   Fri, 9 Jul 2021 04:09:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210709074810.GA1548@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021-07-09 3:48 a.m., Ulli Horlacher wrote:

> 
> So, where is subvolume uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2??
> 

btrfs subvolume show /mnt/spool   will display what you want.  It seems
as though the subvolume list does not include the root subvolume.

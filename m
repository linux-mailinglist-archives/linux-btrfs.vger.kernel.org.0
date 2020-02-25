Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A71D416C273
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 14:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgBYNgu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Feb 2020 08:36:50 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:44191 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729489AbgBYNgu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Feb 2020 08:36:50 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BCFC8F71;
        Tue, 25 Feb 2020 08:36:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 25 Feb 2020 08:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=32Dj5oAWm/kblSBCFj9rUM+soZeVeUew35W9PmGsi
        JA=; b=0d/+fOBkimniPNPkQ4FY1ioUroGNBUsJj0TbRCuGGu71YlZ8UL8bg+KsM
        fBuoENp+VHagsN+1QG3XJkzxBMC8c8Kyun0V/lt8Pxk2aaR2vqkbZhygZTcPqGWE
        liAoAlv9B2CtqAjYHMYQK5JDi/9H74KFKmd0jtCGQvobyooln/1knOVh/3YHBaLj
        92X6Tp+q77KeV3Ny4qZ55REh8o9dBcAovuQgumKDCNUZBwlfNjQGBzboMgGBJBv0
        lPFCmLHExnHMznCaf0PSKgtmKLLKPvr2pWfxXGVruNXTc7UyV/dTN5y4byBpIyzU
        BdXwky+q7ot4nfgVUPAHPG5dNOy5A==
X-ME-Sender: <xms:8CJVXt_Auhi5v0EHyUmPOhcB84jVlU3oHOf3tN__2-26B5IEVFVrnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledvgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtgfesthejre
    dttdefjeenucfhrhhomhepvfhomhcujfgrlhgvuceothhomheshhgrlhgvrdgvvgeqnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudekfedrkeelrdefhedrjedtne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhomhes
    hhgrlhgvrdgvvg
X-ME-Proxy: <xmx:8CJVXpQAkw14nZ2HSjPXOImI8umdPnR6p_c6v_Uuuval3GkP_Sn79g>
    <xmx:8CJVXn-PlCFDN1arRTGQXRI2EF7laJlJNmeT2l9z2qJAszFIJ23jNw>
    <xmx:8CJVXvYJjssQiPwSccRJv5PrA1k-G7WGz_EgQXePD033_tKhhIhUpQ>
    <xmx:8CJVXiIhHhfZ5TPJqXeNJUnxXI_DbRE5qrCgdD9znXKCzCXFfXmkIQ>
Received: from [192.168.0.107] (unknown [183.89.35.70])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3051D3060D1A;
        Tue, 25 Feb 2020 08:36:46 -0500 (EST)
Subject: Re: Reproducable un-receive-able snapshot send
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <e52e68aa-1ad5-b186-395a-6559e3212fd3@hale.ee>
 <CAL3q7H73VL=Rh4ate0TApDJWgkHhJGxy1ibNQVUQEoWCQ_vWvg@mail.gmail.com>
From:   Tom Hale <tom@hale.ee>
Message-ID: <e0c8f291-6a0a-7ab1-c817-ac6f0aac0e06@hale.ee>
Date:   Tue, 25 Feb 2020 20:36:44 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAL3q7H73VL=Rh4ate0TApDJWgkHhJGxy1ibNQVUQEoWCQ_vWvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/2/20 9:50 pm, Filipe Manana wrote:
> On Mon, Feb 24, 2020 at 2:20 PM Tom Hale <tom@hale.ee> wrote:
>>
>> * Send aborts with this message:
>> ERROR: cannot open
>> /media/ssd/btrbk/rootfs/TEST/rootfs.20200126T0000/o3658332-53841-0: No
>> such file or directory
>>
>> * Lots of directories (not created by me) in the "root" of the partially
>> received subvolume named such as:
>> o1101063-3046-0

> So, first thing to try:
> 
> Get btrfs-progs' source and apply the following patch:
> 
> https://patchwork.kernel.org/patch/11053327/

This patch seems to be pointing at just my problem. Can I be lazy and 
wait for it to be served up by Arch package?

Ie, has it / will it been merged?

[Please reply-all - I'm  not on-list]

-- 
Tom Hale

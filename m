Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB85BA0EB4
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2019 02:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfH2AvF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Aug 2019 20:51:05 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59793 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726985AbfH2AvF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Aug 2019 20:51:05 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id EB8A821E44
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 20:51:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 28 Aug 2019 20:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=megavolts.ch; h=
        to:from:subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=fm1; bh=Q75eWbTgImqXvFySUTvRjRFbGh
        /fIaDxdgY8o4UEKJc=; b=ooJLV3BPmMw5xLq31SYykw71JLptGSTKEIqRzqdy/C
        tkdCs9+wJpsDmOrFf2rulr8qnZUoWAz3k2jxFbLFG3Z3tJeJy5V2r6Toki6+3dA1
        I02qVUT5QJ8F48JFRHBzSTnABlOfi8oJAjMU4iNW6e5Y3oORnT5XoA1kk8PeNhNw
        CqwnorcfQtfpX5QDbMj99PlZoLOn1N8SDpvqJyBE/ek7K+++AyOuObBSuPwlCSVG
        IqjskG8NPoyuEJZFcBCBRnWJmgATtvuc6SJ7gmoXOFiar2JcXOXoIz2r+uO1S21n
        Y+C5Qk9RFj83UqFHZdS1yxmeHOS6Fmic1He7rbIk4EZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Q75eWb
        TgImqXvFySUTvRjRFbGh/fIaDxdgY8o4UEKJc=; b=mTphmxIFZTCAG8Rl93emWA
        IJSn5eU+ZpS8awiO/yvSEsijBzdfA/M7c96xlK3peQVNUm4FPeif4cL7s7k4CJgJ
        VWwr3uc76KcQ0PDe3m4yQJuIHpjUn8FgdKYQgL4bKYzBVIVM2e8gdw3bgIVmoMtB
        3Eeow23CXHSZrCrw4Jjnh0/NQOdpDBxbIwEOnvX6fzCMykRyx2GjLnSFzxeMxVOt
        jP79xiKbLaqK34o5Kz/DqA9dkcecBXHdCUtUoBO0iMAQ05JDzJrs28PfuKmhy0/N
        C/35kcyVLFkM8Mav7J7uxhwmfY4T7vSLvmYqpHpjmPK43T2YFHqq9huBkOcINGYg
        ==
X-ME-Sender: <xms:dyFnXVwWO-C0d3q9JHnlxzYVEhpF0InTEhO8JjooqZOs7FDLfU6JsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeiuddgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefvhffukffffgggtgfgsehtkeertd
    dtfeejnecuhfhrohhmpeforghrtgcuqfhgghhivghruceomhgrrhgtrdhoghhgihgvrhes
    mhgvghgrvhholhhtshdrtghhqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukf
    hppedufeejrddvvdelrdejkedruddvudenucfrrghrrghmpehmrghilhhfrhhomhepmhgr
    rhgtrdhoghhgihgvrhesmhgvghgrvhholhhtshdrtghhnecuvehluhhsthgvrhfuihiivg
    eptd
X-ME-Proxy: <xmx:dyFnXW0pFr00iviuQ9Gt8Ui3v4BBaTxHK2lH1N-dhWj2fSlS5idUuQ>
    <xmx:dyFnXVp475nTxalFcqrvhrBsklssH99WUHtUPOLhl03CSxSwOCtxwg>
    <xmx:dyFnXTVTtSOgqLs0fTRgUnLaitNQbf5mZginHtH95NAhHts1OSQ4Mw>
    <xmx:dyFnXagSUz-si0UjiEWL7jWgbbOlCZustO_CAdEM0GoYNjdUig0n_A>
Received: from [10.25.167.37] (unknown [137.229.78.121])
        by mail.messagingengine.com (Postfix) with ESMTPA id 555418005B
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 20:51:03 -0400 (EDT)
To:     linux-btrfs@vger.kernel.org
From:   Marc Oggier <marc.oggier@megavolts.ch>
Subject: Spare Volume Features
Message-ID: <0b7bfde0-0711-cee3-1ed8-a37b1a62bf5e@megavolts.ch>
Date:   Wed, 28 Aug 2019 16:51:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi All,

I am currently buidling a small data server for an experiment.

I was wondering if the features of the spare volume introduced a couple 
of years ago (ttps://patchwork.kernel.org/patch/8687721/) would be 
release soon. I think this would be awesome to have a drive installed, 
that can be used as a spare if one drive of an array died to avoid downtime.

Does anyone have news about it, and when it will be officially in the 
kernel/btrfs-progs ?

Marc

P.S. It took me a long time to switch to btrfs. I did it less than a 
year ago, and I love it.  Keep the great job going, y'all


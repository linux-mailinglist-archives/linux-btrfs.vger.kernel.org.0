Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3091F63F8D6
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Dec 2022 21:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiLAUOd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Dec 2022 15:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiLAUOb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Dec 2022 15:14:31 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F20BEC6E
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Dec 2022 12:14:30 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B26565C0183;
        Thu,  1 Dec 2022 15:14:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 01 Dec 2022 15:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1669925667; x=
        1670012067; bh=lqIquc1DYhQzvjY7CfljQ912iHt4pPtb5sJ2dY8PI4A=; b=K
        RvPRo0oj5C8smzwoHHe7LFrr0la6JJS9oby8eyMklGt4ZTk98X/s1U87CCAU6KQa
        7cbkaNNU6ia/9Fxra2yW+HWpw/YQpGxdkHVvRErZAqu7Q90mncfCcIhS1oH/yPdM
        KeEZn4qag1gcOg3yd+EjqRGYqF/bOukn/qGGPYs5XfLCMIJMChePQR1PDipi1UAF
        0eIpCF494t6YmXB5Qnk4lCg8AIKWaN+9IKCXUa034upis4EWiMpKFY5JFYeklo2I
        bwGJjjUBHuXFQmsFBToB9PJczoYTJEBzaGFDkF4PrSziB4kwWakvd9RAn3yR7JhX
        VbxlyimEaqTx5r9LUUOZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1669925667; x=1670012067; bh=l
        qIquc1DYhQzvjY7CfljQ912iHt4pPtb5sJ2dY8PI4A=; b=ENR3t6QMm9kU1iT+r
        ooy2eznNobBFtrWZLIL0sM1Gf0ODIVQVD4IunyCeLkvgr5jzTepGrUJ7ukSi7lHa
        LPZQSHmOcQyUW+/Ocd+miQ2wdCZ6pQgOhCoDpI2u+u60ZC3NUOUfIQZn+M86LFVx
        gS691IC56oeLf3ma8p6ed1IpIMvfehItOgS0u0ggP+fuXJWge+UT3w3yBhnu2CB4
        CLwxwRYRzI1mMO1ZT2kldwyKhn2RANBfLiRB7KRLCbLHkC7YGYvismxdgdRPSa6h
        69+dCge27QmdKq66gsPV6oyUtbwdXHGYAzw4ogG2uo7fmk8GorTY3KmQh4oGq+JK
        ZlDRw==
X-ME-Sender: <xms:IwuJY6sQMBiQh1hxiiaoubEQkm5UE18liM2_J0awKGN9DFIGum6tcw>
    <xme:IwuJY_fWCmsYxwvE9jSp1Roy1mudQnv8mukb3u74kUb1beQVewwRO0e393MORmuTi
    S8TZBKNlhpXAJUi8Q>
X-ME-Received: <xmr:IwuJY1zJ06V8jtSq0GlB0W8VAIOi9xl4wz4UhnROGQ6hLV6e7vS8SqiY8Rp3K_OWYQeBGD7Rms_6QWxKbpXrABjM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdehgddufeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtje
    ertddtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhg
    ihgrnhhithdrtghomheqnecuggftrfgrthhtvghrnhephffgfeeutddtudfhudejkeejud
    evledtudeufffhhfeukeejkeekiedtfffhffeinecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:IwuJY1PQyI-zjj0FSTL_izBJBsc9HiTWMlThtJ-Qwc6Nj0WrGyUS9A>
    <xmx:IwuJY68Jc-aIgdq2bt0N1aw2AJaFPQuGZY-DlcEUPKhPxv61XOuz5g>
    <xmx:IwuJY9X16Kk1WuXJ63HWThxDs8-1xekpt2jwqXqzELKh9LZTf4LAfQ>
    <xmx:IwuJYwlznAZPgodMAKR6kd6pDSP8EhpTHQuMgdguTXlbVcLJQWhQAQ>
Feedback-ID: i10c840cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Dec 2022 15:14:27 -0500 (EST)
Subject: Re: BTRFS RAID1 root corrupt and read-only
To:     kreijack@inwind.it, Nathan Henrie <nate@n8henrie.com>,
        linux-btrfs@vger.kernel.org
References: <debfa7c5-646c-4333-a277-62e98a78a47e@app.fastmail.com>
 <15a497f7-f4f0-6b17-0f90-58b5420aaaaf@libero.it>
From:   Remi Gauvin <remi@georgianit.com>
Message-ID: <fd9ea145-38cb-eb6a-0154-832ed612633d@georgianit.com>
Date:   Thu, 1 Dec 2022 15:14:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <15a497f7-f4f0-6b17-0f90-58b5420aaaaf@libero.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022-12-01 1:52 p.m., Goffredo Baroncelli wrote:

>> [99537.333018] BTRFS info (device nvme0n1p1): bdev /dev/nvme0n1p1
>> errs: wr 0, rd 0, flush 0, corrupt 12, gen 0
>> [99537.333023] BTRFS info (device nvme0n1p1): bdev /dev/nvme1n1p1
>> errs: wr 0, rd 0, flush 0, corrupt 12, gen 0
> 
> 
> 
> I am not sure how is related; but from the above excerpt of dmesg, I see
> that both nvme0 and nvme1 have errors (== corruption). If this is true,
> raid1 is not enough to protect against these.
> 
> 

What sticks out to me is that they both end up with the same reported
number of corrupted errors,,, that would lead me to think that the
corruption is not happening on the storage device but in memory while in
flight.).

I would start with a burn in memory test,, though more experienced
members of this list can probably identify bitflip error in the CRC from
the btrfs check output


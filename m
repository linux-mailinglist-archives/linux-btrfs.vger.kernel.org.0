Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BB0748B01
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jul 2023 19:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjGERyG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 13:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjGERyE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 13:54:04 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB550E70
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 10:54:02 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B4E375C0240;
        Wed,  5 Jul 2023 13:53:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 05 Jul 2023 13:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1688579638; x=1688666038; bh=qNO02zCOlo80oEbn5Oi599JkHwWAwC8JVrL
        KliE/XKI=; b=cIMfZ+Oopb46rG7eiFuVMCnT4oR/sCzPsSMgdc6KO3KplaWJW3s
        ve1f2A72/KKIWeX20PEr46uacFvDruqRApDnndKiqPadRSX8yHWc86EmAD+N7ekc
        2PQ2bWCOmLrQN6ShdkUALc+W2biJL9ZF/6OoIbyVqvlg+C5UpAZejUyQJOYxr7ix
        rxoHpRUvuB8NNwKNGLKo5JHleojW1VqYb0kOMwzzj/GFdIF4QIZkSnj2/dVg7CRC
        ZGS/dmssyDXKdiKbKo8x2dcZjB2niELahTq987tUglVVqy7O6qR0DhgIdGFgQtpR
        mj7rtWdlpfSzKmnN1K8BtW8Jc4pniS8Ch6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688579638; x=
        1688666038; bh=qNO02zCOlo80oEbn5Oi599JkHwWAwC8JVrLKliE/XKI=; b=P
        LUIjvDILJ07k8XM3ONRreC30yJkK1WwLGIUHgV1Q1EsMC+AUyL55c0JQQA6EXMdX
        EnZF2NzQ6C65kK6Ul1CITfCj7UwPd+BTUUjnAxbZC0kza2ZMARx/8R3QCiPuQ1mR
        n/dC1ThfNBw8mlrMLEHaYNmP0f3Y+uUqmGTadvDnfWLte6jzlzZu3UUXctUb+mrt
        Z8idmPnR3NLAAaJD0JzXlRCTkRHIaRKMCgGUWQN/fFHyCeVAJz8Pywy1YHAYABDb
        hzliZ/RWWzwmRQui0CXQFhxt+bSyYlTdhFCHiQMFHxAY7iAJFoQJOMx7S3WUqpb+
        HYjhwitmrm5uVYRW6kPnw==
X-ME-Sender: <xms:Nq6lZEM3Fvi3xkWHjHGmPRW8PnHi_M5We1IqLrXGDf74ocU0IASlcw>
    <xme:Nq6lZK_V1erUrFtNsbcn5yYLPGnLICrEC0ojn8f_E_sVxuQU8MHDmY1gdRY-V3L5k
    jXreHTaNehSZBZdOw>
X-ME-Received: <xmr:Nq6lZLSNu9HZYDtOCXuFH4PpeaFEls9gB21Dn76oOSh3KzELnlsRnOjBpbCFK0t2wWy23dVjixQ6scdSRcvNo0Qhckc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefvfhfhuffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeftvghmihcu
    ifgruhhvihhnuceorhgvmhhisehgvghorhhgihgrnhhithdrtghomheqnecuggftrfgrth
    htvghrnhepheejhfetudduffffgfduheeivedtleekffeludekhfehheffuefggeegkeej
    iedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprh
    gvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:Nq6lZMt5_szrYBpxsDQOJ2sCoE3u1V-ZnrTjYu5wvmsfybwtG7r1_w>
    <xmx:Nq6lZMcBLneZR1Htt5wuA8yamk96x_KeCtVGC8XtbdUW8GeX9BpSig>
    <xmx:Nq6lZA0oisoeKX4Xu26BtdsaxygbTdNPIUdLby84pX6xHgYaVP74ZQ>
    <xmx:Nq6lZIHTIEUMQxjZJojGPHx7Q3_uBHOBMeW8DYdvsnCWVMF2WOFFNg>
Feedback-ID: i10c840cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 13:53:58 -0400 (EDT)
To:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>,
        Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <PR3PR04MB734055F52AB54D94193FA79CD625A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <8a3d7ad6-0ddb-3160-eece-8d6228b9c0a6@gmx.com>
 <PR3PR04MB7340BD6CD63180053CCA023ED62AA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <3d208b62-efc2-afe4-e928-986dc4c53936@gmx.com>
 <PR3PR04MB7340ACCB059FA7C9A22052DBD62EA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <e4237dc0-2bdc-a8b3-9db5-6b0e24b7b513@suse.com>
 <PR3PR04MB7340B6C8F2191ED355D1232BD62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <80136f6f-0575-58e8-ea8d-7053c8af4db0@suse.com>
 <PR3PR04MB734063CF2AEA3709D3AFD9A5D62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
From:   Remi Gauvin <remi@georgianit.com>
Subject: Re: question to btrfs scrub
Message-ID: <743f92ee-19e8-ba45-0426-795a91fc0e0b@georgianit.com>
Date:   Wed, 5 Jul 2023 13:53:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <PR3PR04MB734063CF2AEA3709D3AFD9A5D62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2023-07-05 11:01 a.m., Bernd Lentes wrote:

>> The main thing here is, nodatacow implies nodatacsum, thus it would not
>> generate any csum nor verify it.
> 
> But aren't checksums important in case of errors ?
> OK. I know which VM images produced checksum errors. I delete them and restore them from the backup.
> Then I set the attribute for the directory.
> 
> OK ?
> 

I'm really not sure how we jumped to this being a bug that you should
work around by disabling Csum.  I know Qu mentioned the possibility (and
I by no means want to question his expertise.)... But unless I missed
something in this thread, there has been no real indication to not
simply take the error at face value,, the drive/controller/usb combo
resulted in corrupt data, BTRFS detected and reported...

I would hope that the error detection working exactly as it is intended
would be the most likely explanation.

As for what you can do if that's the case, delete the corrupted file and
see if it happens again, (in which case, buy more reliable hardware.),
or just skip the wait and go right to (hopefully) better hardware.



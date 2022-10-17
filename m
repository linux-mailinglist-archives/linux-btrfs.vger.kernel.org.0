Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A06601399
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 18:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiJQQiR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 12:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJQQiQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 12:38:16 -0400
Received: from mail.bouton.name (ns.bouton.name [109.74.195.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400786F251
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 09:38:15 -0700 (PDT)
Received: from [192.168.0.24] (82-65-239-81.subs.proxad.net [82.65.239.81])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.bouton.name (Postfix) with ESMTPSA id E2B8B657;
        Mon, 17 Oct 2022 18:38:13 +0200 (CEST)
Message-ID: <27aa48ca-6420-fa5b-b20b-4c8e3822215e@bouton.name>
Date:   Mon, 17 Oct 2022 18:38:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [btrfs-progs] btrfs filesystem defragment now outputs processed
 filenames ?
Content-Language: en-US
To:     Patrik Lundquist <patrik.lundquist@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <e1cf9a2c-71e7-0bb6-7926-1c5952de02f7@bouton.name>
 <CAA7pwKMmiTkfUq19ey+bWY3f3f1B90sWs926a18ifBYQG7WNdg@mail.gmail.com>
From:   Lionel Bouton <lionel-subscription@bouton.name>
In-Reply-To: <CAA7pwKMmiTkfUq19ey+bWY3f3f1B90sWs926a18ifBYQG7WNdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Le 17/10/2022 à 17:47, Patrik Lundquist a écrit :
> On Mon, 17 Oct 2022 at 14:00, Lionel Bouton
> <lionel-subscription@bouton.name> wrote:
>> I just noticed a change in behavior for btrfs-progs (at least in 6.0-1
>> on Arch Linux). It now outputs the filenames it defragments and I can't
>> find a command line option to disable it.
> I just noticed it too. You can silence it with --quiet:
>
> btrfs --quiet filesystem defragment ...

And it was right there in the output of "btrfs --help" too :-(
Sorry for the noise.

Lionel

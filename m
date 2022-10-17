Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D043C600DE3
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 13:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiJQLhf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 07:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJQLhe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 07:37:34 -0400
X-Greylist: delayed 325 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Oct 2022 04:37:33 PDT
Received: from mail.bouton.name (ns.bouton.name [109.74.195.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC06457573
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 04:37:33 -0700 (PDT)
Received: from [192.168.0.24] (82-65-239-81.subs.proxad.net [82.65.239.81])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.bouton.name (Postfix) with ESMTPSA id D089A632
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 13:32:06 +0200 (CEST)
Message-ID: <e1cf9a2c-71e7-0bb6-7926-1c5952de02f7@bouton.name>
Date:   Mon, 17 Oct 2022 13:32:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
From:   Lionel Bouton <lionel-subscription@bouton.name>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: [btrfs-progs] btrfs filesystem defragment now outputs processed
 filenames ?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I just noticed a change in behavior for btrfs-progs (at least in 6.0-1 
on Arch Linux). It now outputs the filenames it defragments and I can't 
find a command line option to disable it.

I'm using a defragment scheduler which triggers file defragmentation 
file by file and even recently by offset and size in a file (to limit 
the IO load spikes that can happen when defragmenting large files on HDD 
and T/QLC SSD/NVME with small SLC buffers).
Currently the scheduler forwards the btrfs command's output to its own 
and it pollutes the logs with superfluous information (when 
defragmenting in 128MB chunks I get tens of log lines for multiple GB 
files).

This isn't a big problem and it is easily fixable in my scheduler but I 
was wondering if there is any plan to allow silencing it or should I 
just cleanup the ouput before forwarding it (I prefer to write any 
unexpected output in logs instead of ignoring everything) ?

Best regards,

Lionel


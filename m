Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7D6591866
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 04:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiHMCvR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Aug 2022 22:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMCvQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Aug 2022 22:51:16 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B606196FFA
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 19:51:13 -0700 (PDT)
Received: (Authenticated sender: ash@heyquark.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 68CBE20002
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 02:51:10 +0000 (UTC)
Message-ID: <6270a749-5fb2-0b36-529b-07f0e2ce4639@heyquark.com>
Date:   Sat, 13 Aug 2022 12:51:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
From:   Ash Logan <ash@heyquark.com>
Subject: Corrupt leaf, trying to recover
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello!

I upgraded to Debian 11, and I think in the process it tried to install 
GRUB over my btrfs partition? I'm not sure. In any case, I now can't get 
it mounted:

[ 1692.811909] BTRFS critical (device md127): corrupt leaf: root=1 
block=35291136 slot=115, invalid root flags, have 0x10000 expect mask 
0x10000000
00001
[ 1692.825324] BTRFS error (device md127): block=35291136 read time tree 
block corruption detected
[ 1692.837448] BTRFS critical (device md127): corrupt leaf: root=1 
block=35291136 slot=115, invalid root flags, have 0x10000 expect mask 
0x10000000
00001
[ 1692.850876] BTRFS error (device md127): block=35291136 read time tree 
block corruption detected
[ 1692.859688] BTRFS warning (device md127): failed to read root 
(objectid=2): -5
[ 1692.869075] BTRFS error (device md127): open_ctree failed

btrfs check and rescue=usebackuproot,ro give no dice, either saying 
nothing is wrong or repeating the same errors. I can't scrub since it's 
not mounted.

If it is just the "read time" that is corrupted, I would have no problem 
losing that, but I'm hoping the files are salvageable?

# uname -a
Linux LogansNAS 5.10.0-16-amd64 #1 SMP Debian 5.10.127-1 (2022-06-30) 
x86_64 GNU/Linux

Let me know if you have any advice.

Thanks,
Ash


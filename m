Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EA44EA262
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 23:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiC1VYm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 17:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiC1VYj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 17:24:39 -0400
X-Greylist: delayed 235 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Mar 2022 14:22:53 PDT
Received: from mail.as397444.net (mail.as397444.net [69.59.18.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E63D137004
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 14:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1648501263; h=Subject:From:To:From:Subject:To:Cc:Cc:Reply-To:In-Reply-To:
        References; bh=YfI79WAJd0hnxxCQJsMV/q0aPGuKD7vQlp9zzJMPL9g=; b=rbD8lzdU2z5Xqk
        Oy1OXCpKqa+k+eJ2+NHqxidLD7CTcjiB02J4ZZnGnaaLOB+ubLef2pHy3Jgr30cbLTcCYoeqRabl7
        SD/z7TDpYM0zTdqwBcSNsTmdQK0MRlEVJECQAC3QequnoqIP/uRri3alsgYXFbomDwXxi8dOZD1LL
        rX4qoDh7XjjurAdOs4JxYHozXJvoC8nszdlzOFt7CaDtYLNsonvM1cWuPDmRi/UyEyQp5ydtinVB+
        0PbiS5jwkST33WY+Vg0G6+3DF8cvwVGa1AqxoykajZVN0lBHIdvLoOLh+VxW/V8U1xqNzgbjU65Ps
        dY7Dvq2PSboUuLAfZEAw==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1nYwkw-000Rz8-Tz for linux-btrfs@vger.kernel.org; Mon, 28 Mar 2022 21:18:32 +0000
Message-ID: <61aa27d1-30fc-c1a9-f0f4-9df544395ec3@bluematt.me>
Date:   Mon, 28 Mar 2022 14:18:30 -0700
MIME-Version: 1.0
Content-Language: en-US
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   Matt Corallo <blnxfsl@bluematt.me>
Subject: [5.16.14] csum mismatch on free space cache on subpage
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DKIM-Note: Keys used to sign are likely public at https://as397444.net/dkim/bluematt.me
X-DKIM-Note: For more info, see https://as397444.net/dkim/
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Basically what the subject says. Any time I mount an fs on my 64K-page PPC host mount a 4K-page 
device (so far two-of-two - once a flash drive with mirror and nothing else, once a many-TB volume 
across multiple disks) I see a stream of csum mismatches in the space cache in dmesg. The FS' 
otherwise seem to work.

Matt

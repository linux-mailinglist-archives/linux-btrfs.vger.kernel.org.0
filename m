Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9338376EAC3
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 15:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjHCNhY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Aug 2023 09:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbjHCNgL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Aug 2023 09:36:11 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCDE55A2
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Aug 2023 06:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:
        In-Reply-To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cZrfETVlDpudj+M9faIMHQkQO/KmUc8pu6SCeCvRRKA=; b=MRfrYoGHX3HdSWfnadgnvOa2Js
        ynbaDjQgYLUwuY6X3odzixq6SE+aSockO1Ora4Y+WPyXJYh0tYnnGprfl7uP3l8lfIfey4M6e7Dmi
        N2MmLv4qoGC6EHJoopLiTp1IKTySfxIz1ICLgV5WrHrQKDjrcNizWTZnD2kbnrG4zxdD7ylLN5m06
        y2IZ13HizvOaG1q6OlH3ZfTtcRvWMyrkKrwNFFnBg5HxCCr9VvMe1m8nclDLbdLgJT3WDxKDhg2Fh
        YzieB7eI7srb+GHX5DAeBgDiilBRBi5QapfczcKUl7g56UEbAukHDjPFCAvcdoiejHMfkAaoeK2FY
        O3Fttm5Q==;
Received: from [201.92.22.215] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qRYRc-00Bqcj-9w; Thu, 03 Aug 2023 15:32:48 +0200
Message-ID: <5c32e9d3-08fe-7762-9512-f47a6ddbdfd1@igalia.com>
Date:   Thu, 3 Aug 2023 10:32:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
In-Reply-To: <cover.1690792823.git.anand.jain@oracle.com>
To:     anand.jain@oracle.com
Cc:     linux-btrfs@vger.kernel.org
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH 0/7 v2] metadata_uuid misc cleanup and fixes part2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for the patches Anand! Feel free to add (to the whole series):

Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>


I'm working a feature for btrfs that relies on metadata_uuid
infrastructure, so I did rebase on top of your patches and tested, it
works fine.

Cheers,


Guilherme

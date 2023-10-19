Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2FE7CF231
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 10:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjJSIPm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 04:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjJSIPl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 04:15:41 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C658B10F
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 01:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Qo+uexAgAngUkmxAnxr5IjjGGaDGqUrkPuJwCmDXrko=; b=TWGu3OJLyF0YPFkfopd2SYrJbE
        YRjtBY3pEgGfiGeGawQLT5dqWGp5aReaZmRe1o3yNPOqLWTW4j6n8Ay7Pd2sggk7e8nBrZYElBsx5
        aa9THAZ40LHk/ko82lBZrl4JMtBNvYiDZA6hURX/jf2F7iUkwR6KsM9Jcv307O4Vq+f1CPp5Uwgm5
        BaW0wwbfohJ/Hb4blxNZITHKDQ4yBsPLlIXIDyLjvIYI3U/oLVYaFSmCT9lCxQdlXC6l1S64g+cZE
        s4BeziWYgOHkT2uJkaAwOw5q+TUXqW/LFg2NbTo2lh5yICRbOx8hTrH1L2KfZfiz4cvmHtBfSMsfJ
        yKfEhFaA==;
Received: from 44.red-81-39-191.dynamicip.rima-tde.net ([81.39.191.44] helo=[10.0.20.175])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qtOBr-0028gA-R2; Thu, 19 Oct 2023 10:15:35 +0200
Message-ID: <bd9e1b27-fff2-6932-c9a3-5f31c5f27135@igalia.com>
Date:   Thu, 19 Oct 2023 10:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/2] btrfs: support cloned-device mount capability
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1695826320.git.anand.jain@oracle.com>
 <55f1b487-af24-8f67-8e72-37d493c5025c@igalia.com>
 <dfc68882-ac04-4b11-9ac6-505341e0517c@oracle.com>
 <2a729b71-3f30-d99a-7129-4e13841d180d@igalia.com>
 <2dba310f-03c3-4d86-971d-2f9f94a5c9d9@oracle.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <2dba310f-03c3-4d86-971d-2f9f94a5c9d9@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/10/2023 04:13, Anand Jain wrote:
> [...]
> Thanks for the use-case validation!. Is there a way to turn
> your use-case into a test-case?
> 

The xfstests that was submitted for the incompat TEMP_FSID flag covers
the use case - we just need to rewrite that dropping the test for the
flag and changing that for checking sysfs temp-fsid feature.

I can do that next week if such wait is fine =)
Cheers,


Guilherme

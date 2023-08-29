Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0CC78C687
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Aug 2023 15:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjH2N4j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Aug 2023 09:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbjH2N4X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Aug 2023 09:56:23 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301E6CE8
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 06:55:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1693317319; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=OnODIJxYju35qlu66FlnfeJFZ3S7G/4VtefJiTfj1ZF+FbFEgdG3wIajHq5aSQ8Ye41f5Tk6QWvFme05hovIzGdE+5PxiXvxPjYkfwPZuAqzkTUfeU56KD5vhVT+M8O91EsXHJvf+jo4jaIVoxReCzTUdMSBDDVM3S4uErxNnew=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1693317319; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=spi4Ydxh+1QfTlN9XTslVGcpfaMmajEct0+HRe/RZLY=; 
        b=bZwiJYns4ZzrAZOqCyFjIyyWxS7DU8DARtqUiLO4iv4j+3qfxI1D2qVgEUM3AcemzZtFXwllXlI7uAxvk+xT09Wd/YMeg1IX4U0XB75kHTNXg29AlW2d9+nya9KdR7ia9ny4j5ofakntDa+jKRN9YmMXcWqny8MOZHrn/SSCxwM=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1693317319;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=spi4Ydxh+1QfTlN9XTslVGcpfaMmajEct0+HRe/RZLY=;
        b=atUdcPjMJom1vNauMUZ0mNFjvZh7x/eQaQLFcdtPDhYPkNOJ95Q/iGMMWQAOqTM1
        49gS60hMhisoKTxxmuOVFrubWjG7oKiUEkhGHGqJQQugBVyxgncHoCz5HqROw+pHao8
        3GNBDzclHh3h9xI2HMoL6QoALSOhBZ684dtpdYW8=
Received: from [192.168.1.10] (110.226.17.164 [110.226.17.164]) by mx.zoho.in
        with SMTPS id 1693317317031777.2897551691909; Tue, 29 Aug 2023 19:25:17 +0530 (IST)
Message-ID: <834085d4-8a3c-43aa-a0ba-22207b70c1cf@siddh.me>
Date:   Tue, 29 Aug 2023 19:25:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     syzbot+65bb53688b6052f09c28@syzkaller.appspotmail.com
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        terrelln@fb.com
References: <0000000000006512230604076562@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: use-after-free Read in btrfs_test_super
From:   Siddh Raman Pant <code@siddh.me>
Content-Language: en-US, en-GB, hi-IN
In-Reply-To: <0000000000006512230604076562@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Might be fixed by recent commits.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.super

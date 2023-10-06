Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F677BB282
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 09:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjJFHoh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 03:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjJFHoW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 03:44:22 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B92F19AB
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Oct 2023 00:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wMkonyOaI7v85lBfq7h50QkQ2JzpXhOYJFn9VjALeto=; b=fcxTvqI1H1nylDcx2JbNHd0yGg
        WX9I0XyXZah5Pyl1EIqoopAa0kC2KRDDrzSmplV4ow5pA6K0rOkuLroJJHqq4N3pVXhZ80ZWuOpCv
        qXV0QaD8LIZGc+yY/tzsPIYkyfVQjI0bSG0jLCJOXdG+6CH8zgKlTE+W5afWCOwPVzmK9OObUn5IG
        ab9B1IJXjbnz1206dUWK+5869wTjp2WrNoC9pLuMSFiql/92SyThN4iiQwpr6NXpwSSbj3gxbEBQQ
        SOP1XW+gAbcncRkoE6s/o+uZJKb8g3BLGcKbY2tXZlob1lqL1E4FKCglUrBrybLxW9yIVs8ZYYMRT
        N3vAwgxw==;
Received: from cpe90-146-105-192.liwest.at ([90.146.105.192] helo=[192.168.178.99])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qofTR-00CTAM-GJ; Fri, 06 Oct 2023 09:42:13 +0200
Message-ID: <55f1b487-af24-8f67-8e72-37d493c5025c@igalia.com>
Date:   Fri, 6 Oct 2023 09:42:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/2] btrfs: support cloned-device mount capability
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1695826320.git.anand.jain@oracle.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <cover.1695826320.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Anand / David, I was out at a conference and some holidays, so missed
this patch. Is this a replacement of the temp-fsid approach?

So, to clarify a bit the inner workings of this patch: we don't have the
temp-fsid superblock flag anymore? Also, we can mount multiple
partitions holding the same filesystem at the same time, given the
nature of the patch (that generates the random fsid based on devt as per
my superficial understanding) - right? And we don't use the
metadata_uuid field here anymore, i.e., we kinda "lose" the original fsid?

If that approaches is considered better than mine and works fine for the
Steam Deck use case, I'm glad in having that! But I would like at least
to understand why it was preferred over the temp-fsid one, and what are
the differences we can expect (need a flag to mkfs or can use btrfstune
for that, for example).

Thanks in advance,


Guilherme


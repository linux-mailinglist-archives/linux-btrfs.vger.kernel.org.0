Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F72504CE8
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 09:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbiDRHCx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 03:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiDRHCv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 03:02:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF9F25DC
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 00:00:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8F8C01F37D;
        Mon, 18 Apr 2022 07:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650265210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rWlueotSBNM8IHlesGC1fnBLLUK2HCLvB5OyLehRoU0=;
        b=VdyFqFE92Y0VPzDecuTfq7PCS8pKip9DR941b3f48Ha7foqUM0DF7v1P1fHl1RkYvj+Yxc
        zFVDQXzxcy0bSedA/A4DZeel9euP73zJBB15dfj3wgG/RJOcY/5yn5Akd0nBlzIItnUDUv
        QQI9bB0cflynZ5I5jSnwiBctnmEdapg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1160D13A9B;
        Mon, 18 Apr 2022 07:00:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /rldAHoMXWLLXgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 18 Apr 2022 07:00:09 +0000
Message-ID: <0d70749d-a10c-a426-7a56-c68e0afeb065@suse.com>
Date:   Mon, 18 Apr 2022 10:00:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] btrfs: export a helper for compression hard check
Content-Language: en-US
To:     Chung-Chiang Cheng <cccheng@synology.com>, dsterba@suse.com,
        fdmanana@kernel.org
Cc:     josef@toxicpanda.com, clm@fb.com, linux-btrfs@vger.kernel.org,
        shepjeng@gmail.com, kernel@cccheng.net
References: <20220415080406.234967-1-cccheng@synology.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220415080406.234967-1-cccheng@synology.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.04.22 г. 11:04 ч., Chung-Chiang Cheng wrote:
> inode_can_compress will be used outside of inode.c to check the
> availability of setting compression flag by xattr. This patch moves
> this function as an internal helper and renames it to
> btrfs_inode_can_compress.
> 
> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>

The whole series LGTM:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

Still, providin an fstest is highly desirable.

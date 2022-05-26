Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A74C534FB6
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 14:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344594AbiEZM6i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 08:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347462AbiEZM6g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 08:58:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E4D644EF
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 05:58:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5E1541F924;
        Thu, 26 May 2022 12:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653569912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eDKSsrn2S3gKompf37ExYlvDwOHCmehOe1GSXkzrVZI=;
        b=mQ2MZ90kN/Qy4cI7OnDU5aRBBbuKjXf55GJ/JG+35+aPo2n/NfXTOE/E+GzgKazFQAeuxH
        nPWyV39PUw7iNjNPKJNSOcHCv503wScUG4CAnzWJVNf0IUP9vgYwIrQg4wCXOS84S45DM7
        5dhDgFhRew/91fLsk3TsqpC5o/IS3H8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B6221351F;
        Thu, 26 May 2022 12:58:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VcwpAHh5j2KCWgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 26 May 2022 12:58:32 +0000
Message-ID: <57cee69d-c128-ef73-6c1b-db5d324d0a50@suse.com>
Date:   Thu, 26 May 2022 15:58:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 8/8] btrfs: use btrfs_bio_for_each_sector in
 btrfs_check_read_dio_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220522114754.173685-1-hch@lst.de>
 <20220522114754.173685-9-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220522114754.173685-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22.05.22 г. 14:47 ч., Christoph Hellwig wrote:
> Use the new btrfs_bio_for_each_sector iterator to simplify
> btrfs_check_read_dio_bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

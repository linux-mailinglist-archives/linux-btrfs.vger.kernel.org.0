Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C274B4E5C88
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 01:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346967AbiCXA7M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 20:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346965AbiCXA7I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 20:59:08 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E06B9156B
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 17:57:37 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 30DF180531;
        Wed, 23 Mar 2022 20:57:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1648083456; bh=PQLE0b00BpHeOacDrb/7gwnxAouwJFMivJSQlhDeO9Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M/YTH7He7BokCtvdI1C83O9oSX9+724kAVRFLAJAV9kp8VeOF75gbIBClU05RnCfA
         AEjG1hJoej2pzxjr+ujVFVLBq7DBoTF1zo9xXhXljMrVLPqcmrB0CSzojIf78jpryS
         gJcZDKs5A5gHZ5snN0skfVbhviSRWnZaYh/oJO4j+T032M624Jnn6I3kTlnU23fauK
         RQ4+qb0Xqs1jsD8X6boJ3iNswzNFbXEx9CYaSI2huTFC0t3EKXhCqvWrcN1qqTyq5b
         kSpfq0ILZI3Pp/eaFUD9BqXP+IYzLx56BwdkkBrXO1D967EClIXCvAiJ56X6nKl95Y
         zGI7BOPbWs8pA==
Message-ID: <5d1dd5ba-be39-0e9b-637b-92274650f304@dorminy.me>
Date:   Wed, 23 Mar 2022 20:57:35 -0400
MIME-Version: 1.0
Subject: Re: [PATCH 39/40] btrfs: pass private data end end_io handler to
 btrfs_repair_one_sector
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-40-hch@lst.de>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <20220322155606.1267165-40-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> +		void *bi_private, void (*bi_end_io)(struct bio *bio))
Maybe the last parameter can just be "bio_end_io_t bi_end_io"?

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB572577D03
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 10:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiGRIB6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 04:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiGRIB6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 04:01:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB0DF5BB
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 01:01:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EB07E22B19;
        Mon, 18 Jul 2022 08:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658131314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0WE0YEJUjkZFDuFE0/oaNc9ochHNdz8wiJ5zpPPCPa4=;
        b=AlEDV58Mv2PTU9tr52P7nXqSKo3+MM7TnNWvCREfS/I8C9YzrpvscdP/+6RLzhhiA49PFc
        +QyZNbfQcDHrDkyRfrKk/6WSLvOCq9Klplx2FUGEb9saGeYYPY4af5We5cpneQK/C+czBT
        Ee6lhYYDc2h3RhdNjRFAZQE6Pn4Fzrk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC30D13A37;
        Mon, 18 Jul 2022 08:01:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FJapKnIT1WJZBAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 18 Jul 2022 08:01:54 +0000
Message-ID: <bf6ecf74-bbd2-5f3c-a5d6-0d182a61636a@suse.com>
Date:   Mon, 18 Jul 2022 11:01:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Odd output from scrub status
Content-Language: en-US
To:     "David C. Partridge" <david.partridge@perdrix.co.uk>,
        linux-btrfs@vger.kernel.org
References: <000001d899d0$57fb6490$07f22db0$@perdrix.co.uk>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <000001d899d0$57fb6490$07f22db0$@perdrix.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17.07.22 г. 14:28 ч., David C. Partridge wrote:
> Total to scrub:   4.99TiB
> Bytes scrubbed:   5.48TiB


What kind of raid profiles are in use on this filesystem?

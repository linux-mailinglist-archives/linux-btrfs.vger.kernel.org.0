Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241EF715472
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 06:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjE3ETV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 00:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjE3ETT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 00:19:19 -0400
Received: from mail.as397444.net (mail.as397444.net [IPv6:2620:6e:a000:1::99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC6A6E4
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 21:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1685418061; h=In-Reply-To:From:References:Cc:To:Subject:From:Subject:To:
        Cc:Reply-To; bh=nojtexACTjZT/ykic8KLRQsZ0Bk9ExiDX/7QE3JCOyI=; b=tnszRxwS/H17G
        sOOts65KjQS4JB41MR3b0HQhloOfYPMMcgDnD45lCLCQxU5NDZqe2nmEtPUrFrefLcPPzf2anjySm
        dhj8uBMBrC4KydXSJIIu89DJtVO3nwtx6vEGyAuJlP+1HUzEFUsDSX0JfdCsvJQ2GFHJQigDt1q+d
        Isw9tQO87g8SsnQ5BU5rDVYww87aGbKzkX3NsxRmoi3Uoq966+J7ZmLGq1snHen+LRwe9vMxMvTVg
        Ij/n6kINixAvi2dyCm8vPl+n/2Zqby/2cSfYcGB3rn9/wsuKn7xt1amnS14XNXjk7iyd67A9lvAZO
        9YvDtyjfWJn/0J2SmrPJw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=clients.mail.as397444.net; s=1685418063; h=In-Reply-To:From:References:Cc:
        To:Subject:From:Subject:To:Cc:Reply-To;
        bh=nojtexACTjZT/ykic8KLRQsZ0Bk9ExiDX/7QE3JCOyI=; b=gr9rvtFEQ9GxEkzlCnUZfpIHXn
        Kr8qNPv5Rza4Wz2nQ+4MoT8R02+FOvrMiJFaBdAiFqDdnIu7JbQbq3s4WEYS3QxBF+kTpLvoYNf1e
        fBuP08HI8qmQbJcW9SG3hUGQYp0R0e+9DmutN7lb5d+k5Pkvj2+dIVJpHGzHqQ3vuXYjwwfWpl93h
        QDpJcIXYf42F/IxLJL+wJsUfCLucmTPNU3eq6BCc0tsIx1neSX3sTm/uOD1aewkU6x+uQVWPgtu2e
        6WIKIf3lFY2Kcimhl1Y89SKrFX9KImBHUK7WkwDkyGSYJJwULzfbKpwmIt8954tM/e+HwEJTRR55L
        Jwzk6cbQ==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1q3qpG-002zqR-1c;
        Tue, 30 May 2023 04:19:14 +0000
Message-ID: <f1e9e97c-40e8-8b51-cb6b-f20603c346a4@bluematt.me>
Date:   Mon, 29 May 2023 21:19:14 -0700
MIME-Version: 1.0
Subject: Re: [6.1] Transaction Aborted cancelling a metadata balance
Content-Language: en-US
To:     Paul Jones <paul@pauljones.id.au>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <bc26e2b2-dcb1-d4a2-771e-82c1dbf4f197@bluematt.me>
 <20230529141933.GH575@twin.jikos.cz>
 <f555f213-f839-445f-7b00-cbf1952d64eb@bluematt.me>
 <1ce06018-3fb5-50b1-813d-5b6d9f2cdcdf@bluematt.me>
 <398f2d12-afae-075b-7474-8ce1b13a2b88@bluematt.me>
 <SYCPR01MB4685449D98D7DC18B085CCB59E4B9@SYCPR01MB4685.ausprd01.prod.outlook.com>
From:   Matt Corallo <blnxfsl@bluematt.me>
In-Reply-To: <SYCPR01MB4685449D98D7DC18B085CCB59E4B9@SYCPR01MB4685.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DKIM-Note: Keys used to sign are likely public at https://as397444.net/dkim/bluematt.me
X-DKIM-Note: For more info, see https://as397444.net/dkim/
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_ABUSE_SURBL,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5/29/23 9:08 PM, Paul Jones wrote:
> Yes, mount it with the skip_balance mount option.

Ah, thanks. Still can't run a different balance as a cancel is required first and that forces RO, 
but at least I can use the FS for now.

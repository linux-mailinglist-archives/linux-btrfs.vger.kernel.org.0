Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D8D76EC57
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 16:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbjHCOV6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Aug 2023 10:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbjHCOVb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Aug 2023 10:21:31 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0902726;
        Thu,  3 Aug 2023 07:21:12 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bba48b0bd2so6973325ad.3;
        Thu, 03 Aug 2023 07:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691072472; x=1691677272;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5lXL6jNOr+JQ+0o+MbkuxmG+29BoCJPCIwZhaOmXrQ=;
        b=ZelEqZUrYq1t/iicz4hp2cVVVpIUvGIwSjDic8q4ru83c4fK4VM3Q3A99c4vDeVVup
         xX64gxmklbWKt+KQ0JTpEwEdjbu+CgedoljPbKRNpacJsfsDxD39pggudxQpMU3TdB/F
         gv21WGiEiHWaau764BqEPAiG9wMPundB1DzGR7NYik8Y5Gv8x77I3NlPElG3K1TFe87t
         pMIXhr8962Qv7MA9UnKsw+0OwCKH9VZ6WNkScAi7p/OhYWU5b8YLRz5nDGmEUcIdFe4C
         IJ+BggPjISS9DBrubXoiGYAKdepiNq4DPNKWZnaaSKYwZwwFOpoSmIZRC+ZdvcvNYAas
         k0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691072472; x=1691677272;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E5lXL6jNOr+JQ+0o+MbkuxmG+29BoCJPCIwZhaOmXrQ=;
        b=eMj0K1trMcbeduTTghXKs2uQuAzEL53fjgEer5vzYpVaxsK3mkVrFtVokFGAqfn/UL
         u3IMl7LlDe4PqL+fv47MVF4LeyW8mdF3QfSNUwSJvkJOr3SXJY6RbRU1Y5fTDELYvtJ5
         iX0pS/R7UR9abYUJYz3pWsjLk+WiLQ+ktbue2ShBmkcNkGRssUo9urHSyuTpOyhwCD1H
         L+2PaSPMM1vcQZoOLV9FhRClsXzoe7xGD55EQOq5O+GOMzdLsisOwnTglry/B2pKGYE1
         DGMrTSkMAuxklG2oJc6t+eANFk6N6ijbhYikVf9HejOizObgaaSuO6MFb6J4v6k8zPdM
         pFGA==
X-Gm-Message-State: ABy/qLabvZjw86sf21CwlFIMhwVZ2tVpNAp6nTJ5nkG9j55x6EnfkpVB
        YqmBMh0qINCN7KajjldM4gU=
X-Google-Smtp-Source: APBJJlG3EScu40/C2MiREogG3Q2YKj/AlQl30W5wCL3ow31o6hOilRMH8KXsBsNNAchZ1ZcfAxAcDw==
X-Received: by 2002:a17:902:e88c:b0:1bb:9357:8b76 with SMTP id w12-20020a170902e88c00b001bb93578b76mr20729682plg.50.1691072471860;
        Thu, 03 Aug 2023 07:21:11 -0700 (PDT)
Received: from [192.168.0.105] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ix13-20020a170902f80d00b001b9d7c8f44dsm14466972plb.182.2023.08.03.07.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 07:21:11 -0700 (PDT)
Message-ID: <36f891d3-0236-d3c7-55c8-0d8a73d4e30d@gmail.com>
Date:   Thu, 3 Aug 2023 21:20:54 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Olivier Wuillemin <olivier@wuillemin.fr>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux btrfs <linux-btrfs@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Btrfs scrub on single ssd reports non existing errors on Linux
 6.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> My distribution is a Manjaro 23.0.0, CPU is AMD A10.
> System disk is an SSD PNY_CS900 120Gb
> 
> With Linux 6.4.6.1-MANJARO, a scrub on then system disk root reports errors  and some times freeze the linux :
> 
> sudo btrfs scrub status /
> UUID:             53e62983-fed7-46ed-b97c-23d19af4f26f
> Scrub started:    Tue Aug  1 13:26:14 2023
> Status:           running
> Duration:         0:03:21
> Time left:        1:12:50
> ETA:              Tue Aug  1 14:42:25 2023
> Total to scrub:   85.39GiB
> Bytes scrubbed:   3.75GiB  (4.40%)
> Rate:             19.13MiB/s
> Error summary:    read=80
>   Corrected:      34
>   Uncorrectable:  46
>   Unverified:     0
> 
> In this case, this report is the last one before the Linux freeze.
> Scrub not always freese, but when it freeze only low level functionnalities as ping or ps are working.
> 
> If Y downgrade the linux kernel to 6.1.41-1-MANJARO there is no errors :
> 
> sudo btrfs scrub status /
> UUID:             53e62983-fed7-46ed-b97c-23d19af4f26f
> Scrub started:    Thu Aug  3 14:17:11 2023
> Status:           finished
> Duration:         0:04:41
> Total to scrub:   66.72GiB
> Rate:             225.62MiB/s
> Error summary:    no errors found
> 
> Ask me if you want more details.

See Bugzilla for the full thread.

Anyway, I'm adding this regression to be tracked by regzbot:

#regzbot introduced: v6.1.41..v6.4.6 https://bugzilla.kernel.org/show_bug.cgi?id=217758

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217758

-- 
An old man doll... just what I always wanted! - Clara

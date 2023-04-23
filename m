Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5DE6EBFAC
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Apr 2023 15:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjDWNKZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Apr 2023 09:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjDWNKY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Apr 2023 09:10:24 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EA51712
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Apr 2023 06:10:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a516fb6523so40450915ad.3
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Apr 2023 06:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elisp-net.20221208.gappssmtp.com; s=20221208; t=1682255420; x=1684847420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yUpAVyNwfQWbM1sHlPlA5gkCIGgef3APj2uj/qSmsSs=;
        b=eCUKA2/9YIjySbdOFoblC/Bxjsv5l7RCUklBLRbJtsncVVyYu9Q3iTPnEqZjYiUhOo
         K9Xfz48rMmAQej3Bd9ZiMt3LAWqhWZZaB3SFPCYwpTGcFDRmZmSBT6AmJdCsB6Jg6WNu
         g00BC0+aWX0qxg/jwWoUs3ovOh2FfU+nBA1U3ozIW4pzl1KbmIj0u1fZ+XaNkxGSxFTH
         FdbMfYbqJFP6C6mV8HiIilS2mhAvhZTAmJ6+BrdbcznhUl+qU6Ipnlbq0uJM/GW6eyiW
         g+8+fjpBcNMqGnuMfGoY3JZ8sS2VN6IKDe59ipWHN03H9VDh48f7wKMKVk6tEu94DX0O
         mSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682255420; x=1684847420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUpAVyNwfQWbM1sHlPlA5gkCIGgef3APj2uj/qSmsSs=;
        b=ZwXQdlvhM8aBQw7Qr/wz8M5BfeQ3AMupSGGMEVN2jkmQhfvV/EWwZ1XsdSt0NP8o3a
         sNTGVCYFSaKcDI39u8v1wv65fqRFYPgClJoRkxnm/IuOh9dppFn5o3FXE3Vu9B/nsGj9
         dXO2pHJaqEVH36T/JlUyeMCcXhbpOEDCeTH8oFZ+2pSmch6OVVgnlY3LsiTSVzmM1iVU
         5PFCkvCSC3JbkuhlEh3rvQcJvDi7SodMiqthzbUoLUNa6WK8SFRG8qjFc68lFgnaah8s
         2qWvZ9YC63McXGiLmEK0i7DQUkjH49/DTVUI6egfG8OUOFOilZtI6I/BktcDg6ZlIE8I
         r2AQ==
X-Gm-Message-State: AAQBX9dZKvs6OBipw/z8ht6XIpwDlairi4pzOJQvrE7Wb2vczBG4m1eF
        E/bqSO4T40DsNnRctK4RlqV0eGmQ5UXfBcrP3PNm4A4PhsC6V/mi93cr+BfkxsB3v0JUQuri70a
        T0EDSSnAzeFHfEgkhQHbsK5v1YSJa6weZ/LeiBEeTsrUVbqt72WoAh03tc9lIMXamxytPqJ70Rx
        3s+hCiivgLV4z7
X-Google-Smtp-Source: AKy350YVgXpcN7lA+5kA4tSavIBPD6KCtn8YUr++VP+PkyjOMX0sS6dE62JNXKah0Q6WFrcJArTgQQ==
X-Received: by 2002:a17:902:bb89:b0:1a5:150f:8558 with SMTP id m9-20020a170902bb8900b001a5150f8558mr10482475pls.17.1682255420184;
        Sun, 23 Apr 2023 06:10:20 -0700 (PDT)
Received: from localhost (fp96936df3.ap.nuro.jp. [150.147.109.243])
        by smtp.gmail.com with ESMTPSA id o3-20020a170902778300b001a1a07d04e6sm5103002pll.77.2023.04.23.06.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 06:10:19 -0700 (PDT)
Date:   Sun, 23 Apr 2023 22:10:16 +0900
From:   Naohiro Aota <naota@elisp.net>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH] btrfs: export bitmap_test_range_all_{set,zero}
Message-ID: <ym2dczwbako3espe6csmpd5qrmj7guzkufgvklsrpbhvvk5xah@hv5cfmj3f4za>
References: <bab3ffe3255379a63b07c4c11ea1a52e1a904f68.1682062222.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bab3ffe3255379a63b07c4c11ea1a52e1a904f68.1682062222.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 21, 2023 at 04:31:34PM +0900, Naohiro Aota wrote:
> From: Naohiro Aota <naohiro.aota@wdc.com>
> 
> bitmap_test_range_all_{set,zero} defined in subpage.c are useful for other
> components. Move them to misc.h and use them in zoned.c. Also, as
> find_next{,_zero}_bit take/return "unsigned long" instead of "unsigned
> int", convert the type to "unsigned long".
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

I thought this patch didn't change the behavior. But, actually, with this
patch, IOs on zoned mode soon fail. I'll debug and post v2, with Damien's
comments addressed.

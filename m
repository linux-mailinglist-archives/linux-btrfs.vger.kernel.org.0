Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1193E6FB609
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 19:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbjEHRjE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 13:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjEHRi7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 13:38:59 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085B5170A
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 10:38:52 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-ba2362d4ea9so2001132276.3
        for <linux-btrfs@vger.kernel.org>; Mon, 08 May 2023 10:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1683567531; x=1686159531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q33wDc8rZxFqRSlZOYTdm3GGMx6rgy4UTG01Xfmf4h8=;
        b=bZKvtP5WF2zCxbD3HRgBgjwMjp4vVc0H1k/HTBMjszHjRG3NyybcfYVRY/f2qp9I8e
         3QdoECMHBIc06WWZD9elJ+l3mw738Jg+0VoJmuz69XtHWuDU5iAs3DncgEb3pBVRyOK+
         jbKRuuTZ/H2Wsu2tr2FdpAQ+J7T5K7ftftqlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683567531; x=1686159531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q33wDc8rZxFqRSlZOYTdm3GGMx6rgy4UTG01Xfmf4h8=;
        b=SubVPgv2YkhhDrv4SFtVlRD3tV6rT91SyOcyg0azxQ3Jhex2OUSJfrThGZzmkcNc+u
         CowGtkGa65Kn9YHycz7ZNaBBbpe+dKoFPXfnRrD8/G3rQZybz3RHH67Z0IUbIBUbojO6
         qmP1tC+Tu64VsqchnU5nTeLncTO/9hkYpgyAy/HE6y3qkzQSLTsvstFEDHeX8lZNQ2sP
         HPITqBcMqfzdajZ6mOYf6wGQkEar/I1goHFHyjLjCmIJxZ3vQbvh+bu6D6FZCi142OBP
         Yj+SgnP2ERK9+Hw0OhEZCzSMOex0Gt+EA5oF/ao8MrWpjZeeWDSdCvYvbhJxE9NbblcD
         Ivnw==
X-Gm-Message-State: AC+VfDzf6og2dXJt2lElNoTkSFosUCoDk51joGgGEG82v8Nt7dsOdhGe
        HofDQ6ZttZPTOrbrHwC8pdFgN6ZBQw+wbgjcv71uYg==
X-Google-Smtp-Source: ACHHUZ5Bbe7537yrdwSK2oc6gBgZHUs0iRrujdhe3EHHrzO1oVmQC4JO/UUYQLvdD2XyUgQpnHtcQQ==
X-Received: by 2002:a25:4c43:0:b0:b96:4634:146 with SMTP id z64-20020a254c43000000b00b9646340146mr11595069yba.60.1683567531736;
        Mon, 08 May 2023 10:38:51 -0700 (PDT)
Received: from bill-the-cat.lan (2603-6081-7b00-6400-aabf-9b73-e743-b6f8.res6.spectrum.com. [2603:6081:7b00:6400:aabf:9b73:e743:b6f8])
        by smtp.gmail.com with ESMTPSA id m6-20020a5b0406000000b00b9b79148935sm2412381ybp.48.2023.05.08.10.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:38:51 -0700 (PDT)
From:   Tom Rini <trini@konsulko.com>
To:     u-boot@lists.denx.de,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Qu Wenruo <wqu@suse.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-btrfs@vger.kernel.org,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: Re: [PATCH U-BOOT v2] btrfs: fix offset when reading compressed extents
Date:   Mon,  8 May 2023 13:38:50 -0400
Message-Id: <168355361214.2671275.17999482913101134777.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418-btrfs-extent-reads-v2-1-772a6be2ea9a@codewreck.org>
References: <20230418-btrfs-extent-reads-v2-1-772a6be2ea9a@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 18 Apr 2023 15:41:55 +0900, Dominique Martinet wrote:

> btrfs_read_extent_reg correctly computed the extent offset in the
> BTRFS_COMPRESS_NONE case, but did not account for the 'offset - key.offset'
> part correctly in the compressed case, making the function read
> incorrect data.
> 
> In the case I examined, the last 4k of a file was corrupted and
> contained data from a few blocks prior, e.g. reading a 10k file with a
> single extent:
> btrfs_file_read()
>  -> btrfs_read_extent_reg
>     (aligned part loop, until 8k)
>  -> read_and_truncate_page
>    -> btrfs_read_extent_reg
>       (re-reads the last extent from 8k to the end,
>       incorrectly reading the first 2k of data)
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


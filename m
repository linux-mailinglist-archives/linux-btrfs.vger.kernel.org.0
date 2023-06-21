Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4017391B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 23:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjFUVhY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 17:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjFUVhX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 17:37:23 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711E9199B
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 14:36:46 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b51780c1b3so49199675ad.1
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 14:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1687383375; x=1689975375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HBMqFTsYTJ6cqyNHE0bmKqwPwK0uftwv+rRWsIsZyTc=;
        b=RxnUWvKwL7Z8Pm/76LYrMz4Z4axg0Q04ifl3JafoXqIFHnc8HD/4C7h9Eoai8D0Yef
         Pu25MwHtu56sAO/EXc36p0OHSnWFbs9ke8rczQGXNskpUzETTfEJsh//7veoS2fe/9Bz
         p9h9oZoCvVHknANlqcDnChBpBw2qa2/I8ctBXi6XcgxQCXcZVD9l4ME5G7fVLmTRaMtB
         46ySLj9czoYlMvdhKMczwrpCaxfv6muDsJuDkN2x0pG7BEZPidA6smUd7Out2oNO6vgs
         ccTp/7W22lBz/sG9RLTfWdluF4AUQvmiZIB+jkseTpjRDzBLGBig3jt13WgaU3Q34irM
         V82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687383375; x=1689975375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBMqFTsYTJ6cqyNHE0bmKqwPwK0uftwv+rRWsIsZyTc=;
        b=I5AOKst30wBSzvMuiqZUZDoD6haPpOBZuCGBH6qu/xEo7kFhtlhlfS6kzrXGSyGgZl
         Bd0DwxK360ZL/KTU8jamBCh1jFnoqk4e4fkLK3B5OHyxP2Bxmhu4b/Egz2oWV/4xwoG7
         kStvaKpBzHjtspuLOzsSnRE6VNgmK/w+JWvZxyCSjhr8yNkmuyWb4ulzyqDCWmVXJYmc
         1rW78C4TRvHEXTEBdWgnvh56WhC1PriYuF/s/e9Lw/xCRjyL9AbBkbOVSLohCPtsWBmR
         DFvv4JRok9padEe5AudZRLxk4J9VjWOs3YCJd4LH0X+/mFK3T1sRtQsiVdWwArJwJqwz
         65uA==
X-Gm-Message-State: AC+VfDy/l+SfZh25rZUTCgiBKZWaIiRlbahkFnSnRfEqUSmcQ4PfyyUv
        fcuHQIqb/oknhc3xVoMZW4ZHMFs9zNeo+6MjvzOU/w==
X-Google-Smtp-Source: ACHHUZ7l4dpiCy2HZ1YMT0mnDlHZBOSgAwCwjusBDU1t6v7hxYCsZneLNAxtlqvR28LEFtQ/gkBQrA==
X-Received: by 2002:a17:902:efca:b0:1b5:1573:7d96 with SMTP id ja10-20020a170902efca00b001b515737d96mr15543504plb.59.1687383375228;
        Wed, 21 Jun 2023 14:36:15 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::2:df8c])
        by smtp.gmail.com with ESMTPSA id jo17-20020a170903055100b001b539640aa3sm3918141plb.283.2023.06.21.14.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:36:14 -0700 (PDT)
Date:   Wed, 21 Jun 2023 17:36:13 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: test activating swapfile in the presence of
 snapshots
Message-ID: <20230621213613.GA13893@localhost.localdomain>
References: <5417083e8e23a1553f428608d02a07aae21b9e53.1687262391.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5417083e8e23a1553f428608d02a07aae21b9e53.1687262391.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 20, 2023 at 01:00:21PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we have a subvolume with a non-active swap file, we can not
> activate it if there are any snapshots. Also test that after all the
> snapshots are removed, we will be able to activate the swapfile.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

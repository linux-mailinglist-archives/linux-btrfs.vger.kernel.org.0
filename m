Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841BA77669D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 19:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjHIRmi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 13:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjHIRmh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 13:42:37 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C707E71
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 10:42:36 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-76ad842d12fso8931685a.3
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Aug 2023 10:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1691602956; x=1692207756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zWWPwDpGXGjuZueAp5ZycPTbOau6aeMkvpoUTddFSUI=;
        b=r2AHlJU3DcJxm6zL68V4S6u/Kp/OqX4PbCFrgy5FKb3oY/0HCA3VKfGdukL+sdM+I3
         tCfffbFRBirZWAWtSYAeizkTepREe5D8ScA9TYZ6E7u3cUi3KxzyzwUlTaiIRf8eKkrI
         fWk38sNbOnygY2gtOEd7fW2tMPzTv83p87JdzMmb72Ivk4hlJPBxGCDFiLBkxNNd69oz
         ICY/2ZhUNqM0lUdv4ED+eIMemE36db0UJ9ZxFVAYH9GlxYNR/WEVDb1giVW3iD7clMsI
         XZNFMxFgL/R4dzcpfyuW9hO3ED8G0VN3GqIhjpC+wOXWUMlMLL2xp789O6+2EUPUkD++
         +fHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691602956; x=1692207756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWWPwDpGXGjuZueAp5ZycPTbOau6aeMkvpoUTddFSUI=;
        b=UXrFiixJ+nK0BDmLLBALjFK7x3VP1RVuuRVLpTRgo2VZbRQki8C12+IaI4xC3yWJnX
         +FLGTU+VLFVaBQ6dLXd4aVF0u+NALaFsMJVUXu0oXwX+rlRY/+5IAPhb2O6UvqGbJgrI
         zsrM0criM6eJQfk06XtqhLwjKWir5G6RX5KjkzftWhjKT942GWvPA0zINbAGLSU46Svz
         mAJYy2CBxmNqhfw/KoMO6ADtUfHH7MO59p5f+GNfzf03OT/XU4dBjmvseNoDEKgE9nCb
         LcS9rYtU0+zpCGpiS0ZMSkxmHuaB4tqHQ9TdvZn9vgv7cz1B5SX+fPHjW8c+g6Ct73RM
         hNIg==
X-Gm-Message-State: AOJu0YyR06yPcoBKT5uelid6oz0WzSsB06RJo0k6lghZN2B/902l46bR
        MS5vbYUWdgw29vCvJFZ1cesViQ==
X-Google-Smtp-Source: AGHT+IGTdTbpjrUoNIxPxJoLp/CslVIeNZeL91A+IWIsVPuYFjytcxEWFcvtqeSHL77//WVqV+/ZDw==
X-Received: by 2002:a05:6214:4251:b0:63c:7584:a3c8 with SMTP id ne17-20020a056214425100b0063c7584a3c8mr3004783qvb.62.1691602955752;
        Wed, 09 Aug 2023 10:42:35 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h2-20020a0cf202000000b0063f7ea0145esm3510770qvk.35.2023.08.09.10.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 10:42:35 -0700 (PDT)
Date:   Wed, 9 Aug 2023 13:42:34 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@meta.com,
        linux-btrfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v6 7/8] fscrypt: make infos have a pointer to prepared
 keys
Message-ID: <20230809174234.GF2516732@perftesting>
References: <cover.1691505830.git.sweettea-kernel@dorminy.me>
 <f62d9d6afba014301fc60192812adc5d4225a0ac.1691505830.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f62d9d6afba014301fc60192812adc5d4225a0ac.1691505830.git.sweettea-kernel@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 08, 2023 at 01:08:07PM -0400, Sweet Tea Dorminy wrote:
> Adding a layer of indirection between infos and prepared keys makes
> everything clearer at the cost of another pointer. Now everyone sharing
> a prepared key within a direct key or a master key have the same pointer
> to the single prepared key.  Followups move information from the
> crypt_info into the prepared key, which ends up reducing memory usage
> slightly. Additionally, it makes asynchronous freeing of prepared keys
> possible later.
> 
> So this change makes crypt_info->ci_enc_key a pointer and updates all
> users thereof.
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

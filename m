Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778F1798984
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 17:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243743AbjIHPEU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 11:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjIHPEU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 11:04:20 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F791FC0
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 08:04:12 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-413636c6d6aso13555201cf.3
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 08:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694185451; x=1694790251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LQC2HN8UKv7hlTeynfkap0984Gkq0PB9o4QV7drFtyw=;
        b=fKfziMxJ3Q3coklB8o+CFlTqrT65QVYSK/PBM0nOlAf87S7008BDKmid2im5HTsnJK
         ce1nXJta3E7pjBJs8XvQxMncRcd3U2nRS/voCITn21LgtaHqEnYOsi7uHGfe6TC5kBeA
         pvsqOfi7nXjmZpsrOAzH5Jx9ByQE9NatYuq/k9JjTl7HU6QTqdBWANMXopptTi0jBnSs
         zeHh3rrcp4KvCDPhweIXBnAiA3TvDJHV6hgK+tmZgYBZp1rMOp9OHZ8NdrwPgZzYWh+v
         42QgNSaAz57NOV2CEZ7NXsGkxJycQidV/auNdXuGH8GOAcroddjh8g2462qivB93qCpf
         uvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694185451; x=1694790251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQC2HN8UKv7hlTeynfkap0984Gkq0PB9o4QV7drFtyw=;
        b=LXwleOvXcB4aXN3cBxVQMnJWqJ1lUF6IGL985fpmOrt1BTCxxomBGVw6BKjf7S0Vga
         vCZyMYv9R5EKkXL4wLPaxcaNI7AXBXhQS29ulFdRfkO52ziMoJN/7njSIXDsH6z+VrPR
         X+acxcCQipOK/TdKQqBOyIfGfnI+C4pX7mOpJGRrkA/Jt/8KhbMNNnGWGg/grz0b32x5
         XT9HXupglwVw9XOUKqCSLlcW/BQSCNuIR0iBkGnZQJR2u9dsENJChWHrnf7ibiOENXuO
         uyJee8knjyeY79clbhAFU1u3d1AOuJz1+Q8F9f2PwKcSPFbA+p4Ziw0jlbcLuZuU9r7A
         ZDDQ==
X-Gm-Message-State: AOJu0YwcyafDYMNfPw79MC65gfDbb2BAZrmkTPq7mHlC8F9YV9oCGnLJ
        F72nebRlj2EIArHM+u5siac713JqgD9i2AFoCmqSFA==
X-Google-Smtp-Source: AGHT+IGlYsnhc0abrjT35nZNgQdi7vIf631ZIbtVCnWV0jcJuD8biaA+t878SFWdQ61p7mS1jvUChw==
X-Received: by 2002:ac8:574a:0:b0:412:1ba6:32af with SMTP id 10-20020ac8574a000000b004121ba632afmr3273902qtx.19.1694185451113;
        Fri, 08 Sep 2023 08:04:11 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id l1-20020ac87241000000b00410957eaf3csm665848qtp.21.2023.09.08.08.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 08:04:10 -0700 (PDT)
Date:   Fri, 8 Sep 2023 11:04:10 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 10/21] btrfs: initialize key where it's used when running
 delayed data ref
Message-ID: <20230908150410.GK1977092@perftesting>
References: <cover.1694174371.git.fdmanana@suse.com>
 <f834c7cc57a73507473d43d40d6c909ebb65fe2b.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f834c7cc57a73507473d43d40d6c909ebb65fe2b.1694174371.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 01:09:12PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At run_delayed_data_ref() we are always initializing a key but the key
> is only needed and used if we are inserting a new extent. So move the
> declaration and initialization of the key to 'if' branch where it's used.
> Also rename the key from 'ins' to 'key', as it's a more clear name.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

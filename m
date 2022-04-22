Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4832C50B62E
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Apr 2022 13:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447067AbiDVLdX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Apr 2022 07:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiDVLdW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Apr 2022 07:33:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026CB54F9E;
        Fri, 22 Apr 2022 04:30:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y20so15791699eju.7;
        Fri, 22 Apr 2022 04:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PW90qCpcw9JhJLd4PJqvcUvBRQnXb0n6cSMgcLtCn7Q=;
        b=KxC8SM8I7xatMtVihig/toj4KLWATMhXuyFZz5d1NZTPzDNzN/hHr3tDE6sxlNduKt
         NoKFu14JpoTD5jfuMqOm55tMjFWTR847weikP4NIWpxk1iYafg21lBvZXEbyRztvqEpQ
         KM+EoFwaWa8jvkP6fOwp8RZ+TAORG8xKX+p0gc79M+EBtDJ2RR3xDaYNKy9ReOMm05N5
         6awfpYUu6Vgzfd4xjeRUSkU6SZnGXjdt3T3OxVNkMUh2D3tJoP+5rZYZuvItbFSgdmAO
         fWD2zBbWy/AtJdPwkcS8CTohRTq/eEBcvfknQNZWGrTqoR07+XF+1YwgYWE5oSx2uFGI
         PPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PW90qCpcw9JhJLd4PJqvcUvBRQnXb0n6cSMgcLtCn7Q=;
        b=btoZHPH0deY4G1IDk3eTJwSw5VnUZ8cyc1YrJ8Gm0CxVfTTIlETQ+svzUtj4RKX8zS
         By7luNPYF6VQp6uop7HNNufUCSGmniB5EGpbuPpWeRyp0SkYpXvioXZ0h1B2MKe0KxOh
         fNyOg9W2oEMINpcTVo1Fm8pA94H86ooz3pO1LC9niq9l7mZEiX6qew1uC/7ENAWSoxII
         1ptJ3g2ZmAWjTV+c8ZaqfDs9bPpMKjryqlcLukrWKzst2dGkFbT7cLP1pDzHfw4uEtaN
         /zVOW1PZhRf2sGVenJWmTKGKcTjIw0NutwtKU13PhlzGimgLruKPC0cCsUDIj+mQwg53
         hjNg==
X-Gm-Message-State: AOAM530u0MOkuzjr3+I0JCcWlOAv7N75M2I+9w4s+iVcuzrUBUZmOc+M
        UCfjzMwzFwKkcKQBxKok4tAFUY+JH08Xublw734=
X-Google-Smtp-Source: ABdhPJwVJPBqcs9F/wBYC2y+7WI+DpVXl2VLu4seddTGdq0CuPOGCl0JWKhtUD2VP34dyeueuVX+GTQrwhLJXXRsTS8=
X-Received: by 2002:a17:906:3708:b0:6e8:9459:88f3 with SMTP id
 d8-20020a170906370800b006e8945988f3mr3545341ejc.629.1650627027491; Fri, 22
 Apr 2022 04:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220418075430.484158-1-cccheng@synology.com> <322a24a2-8ab3-63da-a284-e78663ddd0f8@suse.com>
In-Reply-To: <322a24a2-8ab3-63da-a284-e78663ddd0f8@suse.com>
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
Date:   Fri, 22 Apr 2022 19:30:15 +0800
Message-ID: <CAHuHWtkqKYgb2aBim220GxbvL3=Ss3bGAuyMmJrSh5_EKNtt6g@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: test setting compression via xattr on
 nodatacow files
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>, fstests@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@kernel.org>,
        David Sterba <dsterba@suse.com>, kernel@cccheng.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Nikolay,

> This (as all other lsattr lines) fail for me because of difference in
> output - in your golden file there is a single space char between the
> filename and its state whilst lsattr produces a number of spaces. So in
> addition to filter_scratch this needs _filter_spaces as well :
>
> +$LSATTR_PROG -l "$test_file" | _filter_scratch | _filter_spaces
>

Thanks for your comment. I did not notice the space issue before. From
the output of Filipe's test, there is also only one space between filename
and its state. This is the same as my test results. I have no idea which
procedure these space were eliminated, but I think it is reasonable to add
a space filter here.

Thanks.

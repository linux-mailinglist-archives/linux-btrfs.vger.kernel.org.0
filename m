Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713FA56CD52
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Jul 2022 08:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiGJGNg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Jul 2022 02:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJGNf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Jul 2022 02:13:35 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC335F46
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Jul 2022 23:13:32 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id b81so1157235vkf.1
        for <linux-btrfs@vger.kernel.org>; Sat, 09 Jul 2022 23:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=JGc23Tf3TFHyeD9rRqgidSeGFnZTHZQRRjZdYp6ncfoe8kdOGIQBu6Q0/tYGt59mZT
         QdbSysNRHaYvgX03WRaerGgKRe/dbKXXvVXPw0DVNW4FK6d7SzMITU7inJ8/DCJ35+C2
         Y5hsvydL42qkb/07jZPPw+gyvqXZOVHLx5gRhkEYP31uNK3KoBVlJeVr+oJkW80OvRb8
         RwphVeckIZQT39fqxiokofUgOE9Yr/U5TDatOew6QmV8t2NYwoamSnRIlu5AxNiVKo8Y
         n1BqgGFMZdjQW69frK7Gce+Foqj/ERM04K6nlnLwSar3BIobdE9F9wNi6T3kgeSzvk0U
         bOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=p2806UPbte5FLvRFlgkD6Ff/JIj8S45cm01n0+wkyvaNInWQ5S5zjQDpm35WdB7QDx
         QgenTrX9vD0Dq2cZAcgZJmkrIlmVXwXlyP+398j/+I/ObAEVY9ArdYIMIKc5GG6fQhjV
         5uQYEwAlsod48dW1IcvRoCfpavFAjwT//80vW27mdcnlCtdIdWJrsiU+J2iLsOfhrVhG
         bDk6buQis2slLd7NpZ+Bh0uzq+KayVMVgbDDtD4vBtibCq7T6mbfhUYLd37jKEjmMUXE
         ghYstHWkhdxBS0+P1xaIMcS3chzoQlycr5quJzPABGtKGoX6MVQ53B2+1+zXUyhnWKxm
         bl2A==
X-Gm-Message-State: AJIora9RYvEAo+40IX0atBdMnTtNZmHpzGjjLvkbFlvUn2itM+Q+1GB7
        m10+ZnpSTLUe7bXVdBOy9v7JDkpIGyg1RbGEP7c=
X-Google-Smtp-Source: AGRyM1vksoH63EsnG0ncge2yfgyGroOV8qVkDBq8b30oTkTNs6UicRBZ7LlUc9VD4IL5qENun2kul0n6MvDu67rkwdE=
X-Received: by 2002:a1f:5543:0:b0:36f:e4cb:cbd6 with SMTP id
 j64-20020a1f5543000000b0036fe4cbcbd6mr4356502vkb.23.1657433611470; Sat, 09
 Jul 2022 23:13:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:ad41:0:b0:2d0:d5a7:ba98 with HTTP; Sat, 9 Jul 2022
 23:13:30 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <khanadbul01@gmail.com>
Date:   Sat, 9 Jul 2022 23:13:30 -0700
Message-ID: <CALr78wXjvxsu8sQP7VyQTEOYC1C4YafL5rcLSjXdRELVNhvM-A@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a36 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [khanadbul01[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [khanadbul01[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava

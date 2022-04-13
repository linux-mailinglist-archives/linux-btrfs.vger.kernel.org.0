Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373D64FF132
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Apr 2022 10:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiDMIDw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Apr 2022 04:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbiDMIDs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Apr 2022 04:03:48 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E1D27B01
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 01:01:22 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id f32so870783vsv.1
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 01:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=WK6OLngTEGMQZnXAmgyK8gksEaTtYBKX+MRhgq0dtFw=;
        b=c4D4vRI6kkFEYLQ+5unGMnTTMLS4X36JD+u/Gl33QQdiAYbpahK+VMZzCl118Tjoj2
         y8OGvpZ3KrIVagMlZgDOt9tfHtWKZCaGRaNtbkDwtlBSVq2ClA2lBHMS+RywrK044+gp
         fD201zsgX50FxLwzW4r4fZFY5vvJlZ2Z0vsdiLNJROd+Z/rcLjzmvS/bcaea4evl/ijh
         VxU+b91pCU4nQcwrb91KNLlrpH720VacKj8AnecaJqOUX6TgvdABRQnNbL/mHNbddd7H
         UE+OuMvaTsUeLPbz5uY685R3joj2aeudy0PX3dCkruMOL+VK9PwH8JUV0WQ8YLabov3H
         sFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=WK6OLngTEGMQZnXAmgyK8gksEaTtYBKX+MRhgq0dtFw=;
        b=MPeTDuet8os6Nn91ZbSInKVQcUKL7/5rZYZ7CUqidHcnQ1EiZCOivunOJi7JvWFs1w
         b24eJAvwQR9FQ1sBoHIEuJ5gp5deAyIk6Im5Wor29kbrmYcgsuWigObY7MS3NxjlBDgS
         QUuRdcgq5hO61G4P9Nx+3a6n7wUIQJWH7Gkw8Sj7pNtPKTps73otMvBLL8GvpWmoe99b
         mcfazyTNJibAxszyp1NVILPQ+R/wCA1M/J1x7y/xhWZUTTXToiaFAD7k3AaeFnOXfDB4
         x/SpzVaLQ1o1k8uRd7ENlodUHP67H7Z6FjosZrYGPrjmUgOdW1W6L4Hv5Nf65KVcicyK
         fYiw==
X-Gm-Message-State: AOAM532/YDEFKNi0RKd3GDiaaKwvk8Zn0Ow4Cd5MgV19aGDi1MeY0Mmh
        /5PYchFCy1+WuhtNzxuSIKD1+prtG6XpKTkh8cQ=
X-Google-Smtp-Source: ABdhPJzRwvkKFI8l/S4ABs9h6o7zNlsHMUr8QC296sUI28p8BVgE5Bu+0TPatdJ3ohk5j9+COmwjlNIfYJG6UBwlUZ8=
X-Received: by 2002:a67:ca8e:0:b0:328:166e:5979 with SMTP id
 a14-20020a67ca8e000000b00328166e5979mr8874944vsl.21.1649836881783; Wed, 13
 Apr 2022 01:01:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3145:0:0:0:0:0 with HTTP; Wed, 13 Apr 2022 01:01:21
 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   Kayla Manthey <elikounde@gmail.com>
Date:   Wed, 13 Apr 2022 02:01:21 -0600
Message-ID: <CAGwZt9T01qXDxn686nAZYe9b1-Yw89PfXWiJZD--TQOwh5Rb_Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Greetings,
Please did you receive my previous message? Write me back

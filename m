Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3398A76F6E3
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Aug 2023 03:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjHDBXu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Aug 2023 21:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjHDBXt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Aug 2023 21:23:49 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2929423E
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Aug 2023 18:23:48 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76cb0d2fc9cso116712985a.2
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Aug 2023 18:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691112228; x=1691717028;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BpcdbHn0UI/WIIKXIBKs3DBc+4Yeoq5YFgI6Wfs2Dr4=;
        b=P4wbRtarYPXyIuzkDDEgdfiPCZOpM2eoE0m++oTObM74vDCibsiDCnA6jXrE2LJsRv
         xedjyoDkSfHY7lwrNo7KEbF3FIAgF3V9jZaREolr8Dby3QDx6kHWZJXgy3WW6I97BdFc
         f/YumtasPw7fxEaULwksl1js/t8mORkwbJmDq1BjTfa61ew6j9GCLdZdom56IWiL8tNj
         BNV0adoa8djSHlmn851cdH7JCvq43Hz1D5psBL7y6AMQuBMgxHtU0pgxNGyIBGB6/el7
         j9p4PqWEpL06ws6sINqiQzzY1GnsAUOa1ngYKckvSsQN5TW1KWFLye/p0/VvInXwJBme
         Ou5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691112228; x=1691717028;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BpcdbHn0UI/WIIKXIBKs3DBc+4Yeoq5YFgI6Wfs2Dr4=;
        b=hA8lq5o//NqIAmg/+AUNAsaP6mbvxEub/lfISvR487SzQtrCRgA6AJBFWkXaDjVXvd
         1kmIKUHh+ZAyjWdAusF+B4k1FfCoqhVhnEO0I2Y0z2boUf8VhBf3CZ5vddCO8mtxVoIm
         gge2OIgN5Z2ScrrdzP9IXXTkoYrlYaeQNsQMEz8U17YFwQ0SApfbU6ZxoVtUjHnNE+5w
         66oHuWfTlnJAag55qV9tH57xrY617fbd8K/hNUb3VqwzQ1800U4p/TPkSUKk1x9z6ag0
         N60K1Iz7xE6Sya0G/zghujgqm+943ytKRk9wRQTvxw0q0R7hqP+siByrizwppUvQgcRQ
         yOzQ==
X-Gm-Message-State: AOJu0Yzz5TfjtLWv6tmG/mti5bzAHqa/e2dmhJJIjISV0c2nfg76kVOq
        YYnxtx6wePR90GkJ5fTlrKs+wkGiWPQ=
X-Google-Smtp-Source: AGHT+IGcek7KMuOyKFwYhoy1kKtoi8mpDdtsKTkJscGdPTLTW0QPHvDG74RNKdjDPGIMNzMIMzx2JA==
X-Received: by 2002:a05:620a:42:b0:76c:a957:b304 with SMTP id t2-20020a05620a004200b0076ca957b304mr404838qkt.39.1691112227725;
        Thu, 03 Aug 2023 18:23:47 -0700 (PDT)
Received: from digitalMercury.freeddns.org ([69.156.163.190])
        by smtp.gmail.com with ESMTPSA id g24-20020a37e218000000b0076c98dad91dsm303359qki.120.2023.08.03.18.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 18:23:47 -0700 (PDT)
Received: by digitalMercury.freeddns.org (Postfix, from userid 1000)
        id 55814E3D2D8; Thu,  3 Aug 2023 21:23:38 -0400 (EDT)
From:   Nicholas D Steeves <nsteeves@gmail.com>
To:     Boris Burkov <boris@bur.io>, Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: permanently wedged in filesystem, fs/btrfs/relocation.c:1937
 prepare_to_merge
In-Reply-To: <20230803211258.GA3669918@zen>
References: <a44b85f5-01b5-40d5-a067-883d9223366a@app.fastmail.com>
 <20230803211258.GA3669918@zen>
Date:   Thu, 03 Aug 2023 21:23:34 -0400
Message-ID: <87fs4ztxbd.fsf@digitalMercury.freeddns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=-=-=
Content-Type: text/plain

Boris Burkov <boris@bur.io> writes:

> On Thu, Jul 20, 2023 at 09:42:37AM -0400, Chris Murphy wrote:
>
> The btrfs allocator is far from perfect and despite a few measures that
> attempt to prevent fragmentation, it can still happen. If you have a
> system that reproduces this, you can consider using the scripts I wrote
> here: https://github.com/josefbacik/fsperf/tree/master/src/frag to dump
> the fragmentation level of the FS (and even visualize it) to confirm my
> hypothesis. I'm happy to help you get that up and running.
>
> Now let's suppose you do have a workload that challenges our allocator,
> fragments the data block groups, and chews through all the unallocated
> space. We have a lot of those at Meta, so luckily, there is some relief
> available.
>
> Fundamentally the remediation is to defragment the disk, which we do
> do with data block group balancing. You can invoke this manually with:
> `btrfs balance start -d<thresh> <fs>`
> where <thresh> is a percentage fullness of data block_groups to target
> with balancing. Lower is more conservative so you can start low and
> increase it to 80 or so till you reclaim enough space. If you use that,
> it's better to do it proactively periodically rather than after you get
> stuck, 'cause as you saw, balances start failing with ENOSPC too.
> (see point 2. above :))

Would it be useful to use fsperf's frag (module?) in combination with
the required btrd to periodically assess the state of fragmentation?
What are the downsides of doing this?

I'm specifically interested in minimising the risk of "everything was
fine until the fs blew up", and it seems like running this test
periodically would provide useful data that would inform the sysadmin
about whether the risk of rewriting data at rest with a rebalance is
less than the risk of encountering issues triggered by the less than
perfect allocator.

Because it sounds like there still exist workloads that necessitate
periodic rebalancing, sysadmins need a way to determine the degree of
need for rebalancing in order to define a mitigation policy in a
fact-based way.

Is fsperf the correct tool for this general case, or should we be using
something else?


Thanks!
Nicholas

P.S. Please CC me in replies.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEE4qYmHjkArtfNxmcIWogwR199EGEFAmTMUxYTHG5zdGVldmVz
QGdtYWlsLmNvbQAKCRBaiDBHX30QYdnnD/4uZi9iCmK/BsjVy7vEvezWQzvXW6tM
L8GoOcXsqprQXeNPtUM0ZqXnIUQbFrqI/mrzhFlsItL2KWr5l3Lr17dt+D8ubaCm
J57StzvyBqRDRMHJqsvtbMRvdSGi5HkpFSfTywR+5Zunp6pEa7cnxVpy62K1el1b
BP2mZ53LRNYUXrBZVCVN7Fxi8Iv3V6MgQWClwelFGSpNmqz91qZ6mJec+p5lhaLA
qWg5OOPetMCgyyGvBjwMP4UfkdfyN0/1N9AzYowNYm18+EBM8AkQ5QobcVBdZ6bw
z3etpk0xhCzAil19TgpiVnRfnESmOzyhXkOAalI0PGAQbuRbyh+hj9fn2pWIbxLl
G683FP2rT/6GAvGHiRto0bFH0cECUuk4AoZ29C7wUjiLRiddEugY1v3ZwmjJfpjH
iavcvcDZ9rUS8ELRsMajWjqlcu65br9ShnszzMQaEOGpI+hZstzfN9wbv6RyBkQu
s6MNgFfh0wfh4yndAcCP+C8Gm4l8SQizJx8LmKUt2ebYKKCRkDYPahNtrzXUGI62
uA9un4nvUEdRXOU1F5K5GQmDLxENhsNo2Va0p0efDKRdNlu25ITzKm4WSyr6NIx8
jMa77xlriDqdp/kXk1iP5eU5s/gNSTWWgERSrXrsvLJDGzs1/+6sYLf9GvRdS0aD
scsEK0/WDDnyEA==
=8BnT
-----END PGP SIGNATURE-----
--=-=-=--

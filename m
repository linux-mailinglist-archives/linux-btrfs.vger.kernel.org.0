Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A715B70C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Sep 2022 16:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiIMO3o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Sep 2022 10:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiIMO2M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Sep 2022 10:28:12 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA71696CA
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 07:17:45 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-12803ac8113so32439313fac.8
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=AneUDHAl/i/aRgrj3klIt18d+p446smi1JlUslQdfLI=;
        b=DQ2LfwebDBBf1fIRuvusEZgjemunRcIfK35/5cnpT5a58Q6SzjWltCgQeCBWs+Pwz3
         ZKQH+PIMfd/tDn1dFfiO4730BOEZVnxkGy02AH+wvTu4KPvWJT70hz1Fju45Mg5YGdyg
         5bHg+mkFlg1P7BDA4DYaFgDHWcEIHq/HcABrTDSN4+EkE1bKs546tPmzbEduEM8tn7U3
         IC1XfauNxSpm8+caoE1Aiu6GW/Zux+7Oh0XNU2F4o2p0DufkpuNFTTlRsE84lBCZZceN
         XHyrpLaPMBxNYELpGfHA63K7QukTP2Ad8od2iWgll4q8hZOkQsUWQKE0cyi4YuRwsQ9I
         mzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=AneUDHAl/i/aRgrj3klIt18d+p446smi1JlUslQdfLI=;
        b=SG9vzESTyzJLk/n442aIDmM4Vh4KYRLS3GHggpYmmsxlCRSOwxFjwssEdhJi3wz+dZ
         9wuNREG2OUflV8ZUKQZH2OrOTAXWewbnrA+SIzgQD36LfWuV/I6YHdpiWFHesYfc8GfT
         HDQ3l6r3Ws+lEhQ+HKYk1jZlydPBd/YdIrkrWvZipdbDCwKz41kiVoboK8BK200LL+Nm
         nEA1BrKYnCxVY/39WHUC4FJOrgHsPFJELV+obIqnvZxFRS3wT8DnbehkRxMfTj2y5y5q
         HYEXaR2rCAyYTGN/s7qss95ifD71dE2K0ggY0BZvS/NdknVLoxLiWIeM5DXN9QDdLjoW
         LZ8w==
X-Gm-Message-State: ACgBeo1vHr7ZUyIUjk+vJvJqYnlx1Y22Nr88XPjSKUBOSVmSwSjRZVo/
        G1tC3rXrTgI7cIjYiuhMHmQYfgFdqAA9NPVICQEI6FtQElNRuQ==
X-Google-Smtp-Source: AA6agR7ugUr6zRUug6jUgNVv438VujoAx+CBpfgHsrZbWmsitFLPZF9JyBxAkcxj3pIcf1WR3FvDzrxvxqgmVwK5DHk=
X-Received: by 2002:a05:6871:96:b0:11d:ca1b:db19 with SMTP id
 u22-20020a056871009600b0011dca1bdb19mr2028222oaa.74.1663078542420; Tue, 13
 Sep 2022 07:15:42 -0700 (PDT)
MIME-Version: 1.0
From:   Mariusz Mazur <mariusz.g.mazur@gmail.com>
Date:   Tue, 13 Sep 2022 16:15:26 +0200
Message-ID: <CAGzuT_3UVJuXeDjQ4CtM77TO2C6WoBAiWyyBi59_wcv3p7znzA@mail.gmail.com>
Subject: Is scrubbing md-aware in any way?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, it's my understanding that when running a scrub on a btrfs raid,
if data corruption is detected, the process will check copies on other
devices and heal the data if possible.

Is any of that functionality available when running on top of an md
raid? When a scrub notices an issue, does it have any mechanism of
telling md "hey, there's a problem with these sectors" and working
with it to do something about that or is it all up to the admin to
deal with the "file corrupted" message?

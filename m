Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECC064DED6
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Dec 2022 17:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiLOQmH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Dec 2022 11:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiLOQmE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Dec 2022 11:42:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE7432BB3;
        Thu, 15 Dec 2022 08:42:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0D954222B4;
        Thu, 15 Dec 2022 16:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1671122522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E9bpcAOTjeaFvcz21E3nw7xuynTNMqtS98FSUTZZgWE=;
        b=a/aGlAx+u4cOo4HxN6J26nKFugnzpWthfpKhrLTTrfWilc4FUeB3Yh9/kjGyuXi0eF4ZTs
        EuQKf4LuJRK8NS0fOkpJ9cZqIiuEoEgRbIeR7BBA1WJR4S/jgjoxmto92FCdWTn5Z1OseD
        kgUmvcI5WI2fO+Wr5rMBfRDiGVmAtlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1671122522;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E9bpcAOTjeaFvcz21E3nw7xuynTNMqtS98FSUTZZgWE=;
        b=dcAHSBfwvPm5IjxUaNOsKnbXbIGBfHO/M+9TQq/1qnWdh/CA6X/UkZr0rpX2kTBIwSgxd3
        gFvDwHIRNui4MZDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3019138E5;
        Thu, 15 Dec 2022 16:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 27zyNVlOm2PlJQAAMHmgww
        (envelope-from <ddiss@suse.de>); Thu, 15 Dec 2022 16:42:01 +0000
Date:   Thu, 15 Dec 2022 17:42:52 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [RFC PATCH] fstests: add basic json output support
Message-ID: <20221215174252.031fcbba@echidna.fritz.box>
In-Reply-To: <20221215114113.38815-1-wqu@suse.com>
References: <20221215114113.38815-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

On Thu, 15 Dec 2022 19:41:13 +0800, Qu Wenruo wrote:

> Although the current result files "check.log" and "check.time" is enough
> for human to read, it's not that easy to parse.

Have you looked at the existing junit XML based report types, available
via "check -R xunit ..."? junit is standardized, parsable and supported
by tools such as:
- https://docs.gitlab.com/ee/ci/testing/unit_test_reports.html
- https://github.com/weiwei/junitparser
- https://ddiss.github.io/online-junit-parser/
- https://plugins.jenkins.io/junit/

> Thus this patch will introduce a json output to "$RESULT_BASE/check.json".
> 
> The example output would look like this:
> 
>   {
>       "section": "(none)",
>       "fstype": "btrfs",
>       "start_time": 1671103264,
>       "arch": "x86_64",
>       "kernel": "6.1.0-rc8-custom+",
>       "results": [
>           {
>               "testcase": "btrfs/001",
>               "status": "pass",
>               "start_time": 1671103264,
>               "end_time": 1671103266
>           },
>           {
>               "testcase": "btrfs/006",
>               "status": "pass",
>               "start_time": 1671103266,
>               "end_time": 1671103268
>           },
>           {
>               "testcase": "btrfs/007",
>               "status": "pass",
>               "start_time": 1671103268,
>               "end_time": 1671103271
>           }
>       ]
>   }
> 
> Which should make later parsing much easier.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
> 
> - Not crash safe
>   If one test case caused a crash, the "check.json" file will be an
>   invalid one, missing the closing "] }" string.
> 
> - Is json really a good choice?
>   It may be much easier to convert to a web page, but we will still
>   need to parse and handle the result using another languages anyway,
>   like to determine a regression.

I'm not opposed to adding an extra json report type, but I really think
it should be plumbed into the existing common/report API.

>   Another alternative is .csv, and it can be much easier to handle.
>   (pure "echo >> $output", no need to handle the comma rule).
>   But for .csv, we may waste a lot of columes for things like "arch",
>   "kernel", "section".

My preference for any new output formats, especially if they're intended
for parsing, is that they're based on an existing standard/tool. E.g.
https://testanything.org .

Cheers, David

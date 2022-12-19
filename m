Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD0D65116C
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Dec 2022 18:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiLSR5n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Dec 2022 12:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLSR5m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Dec 2022 12:57:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DEF11168;
        Mon, 19 Dec 2022 09:57:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B7025CE1047;
        Mon, 19 Dec 2022 17:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF62C433EF;
        Mon, 19 Dec 2022 17:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671472656;
        bh=ug3j/UPwoUC7CxDuMP5NF+qktCZIULDjBb+3hnyyZgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OfXNcCtyzHuQvT4xNmSJcYoOEKjHfiy8KvutevsmxQWq7opAwdoWWm9P7lYM9toaV
         qVH/zmcFrZOotVO3+cQXCzJYBwTK56TCRp6vevVyf3MqevyENzTUsJnY2vSKS5s+dc
         X4DxfbdxjRCWHJbzLeFzgku4uI1Q0uI64YLLmx1iQyM5ds+/Mwtu0j5EQvr8kIk88+
         7GZsk+5RVcGPfGk3m4/nUAfrNZqI/H8stHa42TgQSHkJbNyyw5bMZYE4jYPOL4m5ZZ
         DfBtxuP/+TvTr+aIzBNgxsM+85OQ6jbBS7YZ8ZuYVeDWH7vFRrvarhaxI5zu2RBKOG
         QWKqtuJUY+5kA==
Date:   Mon, 19 Dec 2022 09:57:36 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: report: add arch and kernel version info into
 testsuite attributes
Message-ID: <Y6CmEBltWukgZ3rV@magnolia>
References: <20221216070543.31638-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216070543.31638-1-wqu@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 16, 2022 at 03:05:43PM +0800, Qu Wenruo wrote:
> Although "testcase" tags contain the "timestamp" element, for day-0
> testing it can be hard to relate the timestamp to the tested kernel
> version.
> 
> Thus this patch will add a "kernel" element to the "testcase" tag, to
> indicate the kernel version we're running.
> Paired with CONFIG_LOCALVERSION_AUTO=y config, it will easily show the
> kernel commit we're testing.
> 
> Since we're here, also add a "arch" element, as there are more and more
> aarch64 boards (From RK3399 to Apple M1) able to finish fstests in an
> acceptable duration, we can no longer assume x86_64 as our only
> platform.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  common/report | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/report b/common/report
> index 4a747f8d..92586527 100644
> --- a/common/report
> +++ b/common/report
> @@ -49,7 +49,7 @@ _xunit_make_section_report()
>  		date_time=$(date +"%F %T")
>  	fi
>  	local stats="failures=\"$bad_count\" skipped=\"$notrun_count\" tests=\"$tests_count\" time=\"$sect_time\""
> -	local hw_info="hostname=\"$HOST\" timestamp=\"${date_time/ /T}\" "
> +	local hw_info="hostname=\"$HOST\" timestamp=\"${date_time/ /T}\" arch=\"$(uname -m)\" kernel=\"$(uname -r)\""
>  	echo "<testsuite name=\"xfstests\" $stats  $hw_info >" >> $REPORT_DIR/result.xml

The original commit that added this report format was f9fde7db2f
("report: Add xunit format report generator").  Dmitry Monakhov's commit
message points out that the xml being emitted was "xunit/junit":

    Footnotes:
    [1] https://xunit.github.io/docs/format-xml-v2.html
    [2] http://help.catchsoftware.com/display/ET/JUnit+Format

The first link is now dead, but the second link contains enough
information to find the current junit xml format:

[1] https://raw.githubusercontent.com/windyroad/JUnit-Schema/master/JUnit.xsd

Note that the xunit project appears to have diverged their report
format:

[2] https://xunit.net/docs/format-xml-v2

(Or perhaps there were multiple things called xunit?)

Either way, it's pretty obvious from common/report code that the "xunit"
code is still emitting junit xml files.  I think it's important that
fstests should continue to follow that schema, so that these files can
be fed into test dashboards (yes I have one) that consume this file
format.

Regrettably, the schema does not provide for @arch or @kernel attributes
hanging off the <testsuite> element, so it's not a good idea to add
things that a strict parser could reject.

That said, I think it's important to record the architecture and kernel.
Probably even more attributes than that.  The junit xml schema provides
for arbitrary string properties to be attached to reports; would you
mind putting these there instead?

(I want to add a few more properties now that people have started
talking about reporting again... ;))

	# Properties
	echo -e "\t<properties>" >> $REPORT_DIR/result.xml
	echo -e "\t\t<property name=\"arch\" value=\"$(uname -m)\"/>" >> $REPORT_DIR/result.xml
	echo -e "\t\t<property name=\"kernel\" value=\"$(uname -r)\"/>" >> $REPORT_DIR/result.xml
	for p in "${REPORT_ENV_LIST[@]}"; do
		_xunit_add_property "$p"
	done
	echo -e "\t</properties>" >> $REPORT_DIR/result.xml

--D

>  
>  	# Properties
> -- 
> 2.38.0
> 

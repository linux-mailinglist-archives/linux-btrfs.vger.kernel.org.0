Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E89651152
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Dec 2022 18:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiLSRjj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Dec 2022 12:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiLSRji (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Dec 2022 12:39:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53515DFC3;
        Mon, 19 Dec 2022 09:39:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C965B80F4B;
        Mon, 19 Dec 2022 17:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F926C433D2;
        Mon, 19 Dec 2022 17:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671471574;
        bh=3ybeNYatPhSK4Ru9QK8QhYa5W4WwTDDt+trsi+s6QuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qcVLBAHs0gmXzu/MaPuq9x6CLFrojyQya50Ue4vJaMuBELf5rzfvbbW5sZcBvr+fR
         61tY5DmgFskMT4rS3CoSKYCJbefPNiFITSALEBvLh8JBnd2wRl2YvHlvdGO/RS5H3K
         dbeJDjfVFwOM+aq8HPtDYYWYP3q7+MZmxG2SOZRRZ0GfQGNaqkdx0Ja0JEFOSptzw/
         A/NdEBrIE5kJJkTiSkz1FS3C/2g7N47qBxO1FRqOjMkkWE6syn6bbKJwpO1/aVqJmd
         qdHRz+P3ylBTuOftWMuBHOpeepJnq8F3kj1UDT0bMAcVmvU67gf12EGIx68pqhHGOC
         zt/kN9e5JI2jA==
Date:   Mon, 19 Dec 2022 09:39:33 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: report: always save the dmesg as system-err if
 KEEP_DMESG is set
Message-ID: <Y6Ch1Qq9op2tmB1U@magnolia>
References: <20221216065121.30181-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216065121.30181-1-wqu@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 16, 2022 at 02:51:21PM +0800, Qu Wenruo wrote:
> When KEEP_DMESG is set to "yes", we will always save the dmesg of any
> test case (no matter if it passed or not) into "$seqnum.dmesg".
> 
> But this KEEP_DMESG behavior doesn't affect xunit report.
> 
> This patch will make xunit report to follow KEEP_DMESG setting.
> Since error is checked by testcase.failure attribute, this new
> <system-err> section should not cause the existing parsers to treat
> passed cases as errors.
> 
> KEEP_DMESG is only followed if all the following conditions are met:
> 
> - KEEP_DMESG is set to yes

Feel free to push back against the proliferation of config variables,
but perhaps this ought to be REPORT_DMESG={always,never,auto} ?

> - Using xunit reporting
>   xunit-quite won't save the dmesg for passed test cases.

          ^^^^^ "quiet"?

> This extra saved dmesg would definitely boost the xml size, but if the
> end user wants to save all the dmesg (for later verification), then I'd
> say it's a unavoidable cost.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  common/report | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/common/report b/common/report
> index 64f9c866..4a747f8d 100644
> --- a/common/report
> +++ b/common/report
> @@ -87,6 +87,19 @@ _xunit_make_testcase_report()
>  	echo -e "\t<testcase classname=\"xfstests.$sect_name\" name=\"$test_name\" time=\"$test_time\">" >> $report
>  	case $test_status in
>  	"pass")
> +		# If we have KEEP_DMESG and want full output, also save the
> +		# dmesg into the passed result
> +		if [ "$KEEP_DMESG" == yes -a "$quiet" != "yes" ]; then
> +			local dmesg_file="${REPORT_DIR}/${test_name}.dmesg"
> +			if [ -f "$dmesg_file" ]; then
> +				echo -e "\t\t<system-err>" >> $report
> +				printf	'<![CDATA[\n' >>$report
> +				cat "$dmesg_file" | tr -dc '[:print:][:space:]' | \
> +					encode_xml >>$report
> +				printf ']]>\n'	>>$report
> +				echo -e "\t\t</system-err>" >> $report

Hmm.  Does the junit xml schema[1] (that's what fstests implements, even
if we call it xunit, and even though there's a separate xunit[2] format
that is not the same!) actually allow us to have multiple <system-err>
elements?

For that matter, I look at things like this:

	if [ -n "$quiet" ]; then
	   :
	elif [ -f "$dmesg_file" ]; then
		echo -e "\t\t<system-err>" >> $report
		printf	'<![CDATA[\n' >>$report
		cat "$dmesg_file" | tr -dc '[:print:][:space:]' | encode_xml >>$report
		printf ']]>\n'	>>$report
		echo -e "\t\t</system-err>" >> $report
	elif [ -s "$outbad_file" ]; then
		echo -e "\t\t<system-err>" >> $report
		printf	'<![CDATA[\n' >>$report
		$diff "$out_src" "$outbad_file" | encode_xml >>$report
		printf ']]>\n'	>>$report
		echo -e "\t\t</system-err>" >> $report
	fi

and wonder why we prioritize recording dmesg output over .out.bad when
we could do both?

--D

[1] https://raw.githubusercontent.com/windyroad/JUnit-Schema/master/JUnit.xsd
[2] https://xunit.net/docs/format-xml-v2

> +			fi
> +		fi
>  		;;
>  	"notrun")
>  		local notrun_file="${REPORT_DIR}/${test_name}.notrun"
> -- 
> 2.38.0
> 

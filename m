Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEAD6516D6
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Dec 2022 00:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbiLSXtG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Dec 2022 18:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiLSXss (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Dec 2022 18:48:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2F112ABF;
        Mon, 19 Dec 2022 15:48:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFF93B80F2B;
        Mon, 19 Dec 2022 23:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804D7C433D2;
        Mon, 19 Dec 2022 23:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671493709;
        bh=29LmaNRtNv3GZGxLOfzryhPF5V8abFskIbOKs1Mo59o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FIGlgbLIOaBTNpBfOVBwayMKaN2v8GIgra4G5nYCPNHOytKeNqMfIUGKwNoMxTqI2
         Sh4zf/0N8oJFyDRmqtU937MytfDBI9M3lfJOnJ/hMn3qnhAPaluiI+gJuNUE0qJeFE
         g5ndpCkKWv7iy4j93Vtu0UewPyCgEyxWF2oYNfdwkRcVB9/SUCjgyJRQS7GkFDgSLy
         0j6qILx2zgWkWP2lIo1DwB/7PHZIHg0qL16IeBVYuK/CMkotXbuqyu1x1FYrYG9pgg
         cu2dKTcN5G4HPXloJt2UFTb11Hq0W62A4ztP8gkT97gaGiqJD4D3Z4Zb9TPdFvbkV8
         sW0vhzQCZAowg==
Date:   Mon, 19 Dec 2022 15:48:29 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: report: add arch and kernel version info into
 testsuite attributes
Message-ID: <Y6D4TT9Ids8RerEf@magnolia>
References: <20221216070543.31638-1-wqu@suse.com>
 <Y6CmEBltWukgZ3rV@magnolia>
 <a1bc81ca-49fb-c67a-54cc-403287c26629@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1bc81ca-49fb-c67a-54cc-403287c26629@gmx.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 20, 2022 at 06:30:10AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/12/20 01:57, Darrick J. Wong wrote:
> > On Fri, Dec 16, 2022 at 03:05:43PM +0800, Qu Wenruo wrote:
> > > Although "testcase" tags contain the "timestamp" element, for day-0
> > > testing it can be hard to relate the timestamp to the tested kernel
> > > version.
> > > 
> > > Thus this patch will add a "kernel" element to the "testcase" tag, to
> > > indicate the kernel version we're running.
> > > Paired with CONFIG_LOCALVERSION_AUTO=y config, it will easily show the
> > > kernel commit we're testing.
> > > 
> > > Since we're here, also add a "arch" element, as there are more and more
> > > aarch64 boards (From RK3399 to Apple M1) able to finish fstests in an
> > > acceptable duration, we can no longer assume x86_64 as our only
> > > platform.
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   common/report | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/common/report b/common/report
> > > index 4a747f8d..92586527 100644
> > > --- a/common/report
> > > +++ b/common/report
> > > @@ -49,7 +49,7 @@ _xunit_make_section_report()
> > >   		date_time=$(date +"%F %T")
> > >   	fi
> > >   	local stats="failures=\"$bad_count\" skipped=\"$notrun_count\" tests=\"$tests_count\" time=\"$sect_time\""
> > > -	local hw_info="hostname=\"$HOST\" timestamp=\"${date_time/ /T}\" "
> > > +	local hw_info="hostname=\"$HOST\" timestamp=\"${date_time/ /T}\" arch=\"$(uname -m)\" kernel=\"$(uname -r)\""
> > >   	echo "<testsuite name=\"xfstests\" $stats  $hw_info >" >> $REPORT_DIR/result.xml
> > 
> > The original commit that added this report format was f9fde7db2f
> > ("report: Add xunit format report generator").  Dmitry Monakhov's commit
> > message points out that the xml being emitted was "xunit/junit":
> > 
> >      Footnotes:
> >      [1] https://xunit.github.io/docs/format-xml-v2.html
> >      [2] http://help.catchsoftware.com/display/ET/JUnit+Format
> > 
> > The first link is now dead, but the second link contains enough
> > information to find the current junit xml format:
> > 
> > [1] https://raw.githubusercontent.com/windyroad/JUnit-Schema/master/JUnit.xsd
> > 
> > Note that the xunit project appears to have diverged their report
> > format:
> > 
> > [2] https://xunit.net/docs/format-xml-v2
> 
> Great we have something solid to follow.
> 
> > 
> > (Or perhaps there were multiple things called xunit?)
> > 
> > Either way, it's pretty obvious from common/report code that the "xunit"
> > code is still emitting junit xml files.  I think it's important that
> > fstests should continue to follow that schema, so that these files can
> > be fed into test dashboards (yes I have one) that consume this file
> > format.
> Totally agreed.
> 
> > 
> > Regrettably, the schema does not provide for @arch or @kernel attributes
> > hanging off the <testsuite> element, so it's not a good idea to add
> > things that a strict parser could reject.
> 
> I'm totally fine with the properties method, but still curious why some
> parsers would even reject elements with unknown attributes?
> 
> Isn't the idea of XML (or JSON) to be flex for newer attributes?

Yes, and the idea of xml schemas is to declare exactly what we're going
to spit out, and in a format where automated tools can hold us to what
we've promised. :)

Note that xml allows for namespaced elements.  If we ever want to extend
the format by adding our own elements, we prefix them with our own
namespace and the validation tools won't trip over them.

Though in the end I found enough bugs in the junit xml specification
that I decided it'd be easier to create a new schema file that reflects
exactly what common/report creates.

> > 
> > That said, I think it's important to record the architecture and kernel.
> > Probably even more attributes than that.  The junit xml schema provides
> > for arbitrary string properties to be attached to reports; would you
> > mind putting these there instead?
> > 
> > (I want to add a few more properties now that people have started
> > talking about reporting again... ;))
> > 
> > 	# Properties
> > 	echo -e "\t<properties>" >> $REPORT_DIR/result.xml
> > 	echo -e "\t\t<property name=\"arch\" value=\"$(uname -m)\"/>" >> $REPORT_DIR/result.xml
> > 	echo -e "\t\t<property name=\"kernel\" value=\"$(uname -r)\"/>" >> $REPORT_DIR/result.xml
> > 	for p in "${REPORT_ENV_LIST[@]}"; do
> > 		_xunit_add_property "$p"
> > 	done
> > 	echo -e "\t</properties>" >> $REPORT_DIR/result.xml
> 
> Sounds pretty good, thanks for all the awesome advices!

I spent the day working on exporting a lot more test machine config
elements, so please have a look at the RFC series that I'm going to send
in a little bit.

--D

> Qu
> 
> > 
> > --D
> > 
> > >   	# Properties
> > > -- 
> > > 2.38.0
> > > 

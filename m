Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB6D6C5A7E
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 00:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCVXfi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 19:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjCVXfi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 19:35:38 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D8C233FF
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 16:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679528137; x=1711064137;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W1SCUjQ23EyEctptsWV5TOwPOPbCYYJn03hs1LnVeJ8=;
  b=fyCVauottmTzhz1VFOtpt0KdhCil5N+2g7qM+lmhy4HjURkDQTWETtIW
   mPc9Y/TE61mJpGoeUlmRh+fykP51ovqlbOCt8vWMdBNDLj+nMFN8To2yF
   fD5m89PFz2MqFTdsnldo5cBMIpb3yL0L5l4QzEBIfaq2kg1jriOG2/lXs
   7CquEIIkRFKR0yPs1tQE8ZnFzZYKPT5c1jIS2EEmBOttziS6XpJ2HXCuO
   s3uWP9kfVwJnCzNZ8l9eWq+g3hFtZWI3NfKEjDXJqcLXIDJxS6qeqf/NB
   jHg1yvjrypbPY90EWKbxxO44v9P7gw9j+nMi+5BtWvyhMlq074moBP7YY
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="338330910"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 07:35:36 +0800
IronPort-SDR: ELQlaK7ti3/DO0rxdfnvEwc46Selz0/2i4KXfQ9Dl04dd7MQPtgrsUfkC9/02avpD6M7yGntDr
 FPAxitvwBMfjfcpC3Q9vFn9uNVB0M/b6NVvGENoOyv6SGh8QpEWvbxcJ676wZglbqQbpTzTn33
 zmGGBhhnmEYISHpfHesglamZf7zUESlTzVMZZ+EOThTSUUZkDkEuK4I5co+VSp6XubOd0E96ZR
 GEjeH4TA1d5VWGto0oKqnUu+Vj19UPsfFQ8xNYpu1INJQQmxuX1aA3T8ABYkRuclqaXYpZpMTj
 Uqs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 15:46:13 -0700
IronPort-SDR: LbOiWbwRsTo/SOV4dGQKeiVY0/5ahf/X6ZP6cIQqF2HIX7aqeL+8oZVA9uIxR0qE7yJRK41HXK
 Mfb0xBncTQQdxrxZifrZ4fNvj6s8dBGKX3bJ3NQZ2cylhv7DDMg8gTa0bS91RGSMawZ4FDbczE
 8PKkx9Imor+5t2XkoARCvlmJM2l6HMQFD89SBZwnQVgs32T0FRK+gVCS6zFzrf2J6wWbjcNONM
 qoZWNRoGhP9/E0w3PHJW5zmp+fv/EKGC4uq+bD+9nI2xOrHCx3GwaiF/X0CkC8s9uaPLF/jUXR
 tlY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 16:35:37 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PhlG041Ckz1RtVn
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 16:35:36 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679528136; x=1682120137; bh=W1SCUjQ23EyEctptsWV5TOwPOPbCYYJn03h
        s1LnVeJ8=; b=TaTpD84B7JLMH24EuTJ3NTeONBK0qa6HRD4kZYgHfWraGeSvPyZ
        XE2Sdt6oTgwylOE8fnP9v2uJ3CrIsWK+jVqGODahW1TNs8QOVT81W1cpuR0Q5GUU
        Gpo7+NDnCqk5iXwLqC2yvApaQ+qG77tFjcImkihHsnZxJWmqtkk+u5HfXwL1Ff7D
        OEUdEEU+djzoCnxFxHNSC5APu9k28kFVdYoxbSxpOjYdI/lua87+9QNS6r2VoJZH
        bZQYGqdFh2IU4zZg9TsjqAYbnymJHHzGMiBSwg+elGpvFkHQtXGIOm21UjwucPAI
        tlnGOYOq4R0IfXxH6kIg1A0BbNAnnvoB44A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TxSg7CY08emb for <linux-btrfs@vger.kernel.org>;
        Wed, 22 Mar 2023 16:35:36 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PhlFy6yl6z1RtVm;
        Wed, 22 Mar 2023 16:35:34 -0700 (PDT)
Message-ID: <709c647f-8d4d-182b-2256-d8a5f84b9c60@opensource.wdc.com>
Date:   Thu, 23 Mar 2023 08:35:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 06/10] btrfs: convert to kobject_del_and_put()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230322165905.55389-1-frank.li@vivo.com>
 <20230322165905.55389-5-frank.li@vivo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230322165905.55389-5-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/23/23 01:59, Yangtao Li wrote:
> Use kobject_del_and_put() to simplify code.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Acked-by: David Sterba <dsterba@suse.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research


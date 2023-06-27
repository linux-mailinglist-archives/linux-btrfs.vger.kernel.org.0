Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F42C740392
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 20:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjF0Stn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 14:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjF0Stk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 14:49:40 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B221727;
        Tue, 27 Jun 2023 11:49:39 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B7B0A5C014D;
        Tue, 27 Jun 2023 14:49:36 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Tue, 27 Jun 2023 14:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1687891776; x=1687978176; bh=nATJEBkpfA+NbocJryMIgV1o0zOuToL8sOF
        QdF/jge8=; b=nbQ+zz9IfDoSnQGxKKBsUzB53MYoMPdc080ST/ZeeC0TpzbMG6K
        RBu573wma6jakK9a35QttaXX3dPM6OkoXtBEXheed5bFmqyor/VS9d16Rj7yfNjO
        IbDOFv+TKP8+TJSCr2rL9F5DfcM3/dsrpFcMJLEhM1WF2C4KIXGMwStu84noSfMD
        7mGUYFWUw5eeoOgJM72B5hvWkpmeNdEzkDUIz/lZXVDRJqMg48z8ifjn4gmQlPf2
        6gVi+LeStP7HlM8fdqDda47OX0RkBv0/zKB0JKvm8XJ5FcyXtPUabOSeKvZl9Y/4
        tuJ7c1qwlUe3iukl3IWORAB3PLg79k3WpFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687891776; x=1687978176; bh=nATJEBkpfA+Nb
        ocJryMIgV1o0zOuToL8sOFQdF/jge8=; b=g9rHtF4Ncyed9+GFHfNHbMMeshNbl
        DhrgmnDAUPa6q9jj3ImTI0MudkGaHOHYsZzZMJU6/iVN7aa7P4phldV3csykbo1j
        VrVnyrDECdBehBnzKJVbeRox7qb2AGpaHMWcXpOGpeaG6t2/YZaZKzd8svOR2B8g
        tr+gFqC8TWV/7TpIqfe5OpLPFoiXj0ezoizdDDVLYB5/Y3w1Xo2cAOrBhmLo5U9G
        qOVP8CVqycWJRqIpMvdNnoLUWHuwJChHBtJQGaQYEtE97hKcnfugJgS+FOvI+L8y
        d5WU4k58ASPQzVez7xP/7cvM+u93lpf3U5Du7CcI4jzmn2zw8TPMwHUzw==
X-ME-Sender: <xms:Py-bZF2_3gbT6uf9WB3ppdvevNyjvPJdX1x14MIe1_P1LuHsT76xGg>
    <xme:Py-bZMEkd2T_4u0ljIVf_y2ov-3aeTkIlsvhn7xx4s85Rql0DvVV2WNt2S1bUuArX
    jZlmyc7lWMN2oqDY2o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddtgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdevhhhr
    ihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
    eqnecuggftrfgrthhtvghrnheplefgfeduvdfhheeviedutdevtddtjeeukeehleejleet
    tedtueeutdeuhfffheevnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlihhsthhssegtohhl
    ohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:Py-bZF5kDAmFv8o3-mXduSl01WogrLI4cHwWeCqZTkJs-G_m94U_Gg>
    <xmx:Py-bZC2c_kv70drDF224cAGBxuEbri4SGPHUDoc5xxpQVkmxH4OREg>
    <xmx:Py-bZIGxeFcAzMS5RYj8Dn6O-VXGF-jLpKzWyKJrSkYqxJMPquMhjg>
    <xmx:QC-bZEgFfil7H2o_yOCOBDjU52iSXiY1NboY0Kdj7NskRHcfnF6EQQ>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6E4BA1700089; Tue, 27 Jun 2023 14:49:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <0943bc38-34a4-4c38-8e91-9aa6446fb15a@app.fastmail.com>
In-Reply-To: <ca3f483e-38fc-786b-d85b-35d543a701a9@alu.unizg.hr>
References: <5ce1e20e-019b-373f-f412-31fdb2c2379d@alu.unizg.hr>
 <ffa970c3-6907-023b-c8fb-7438694b24ef@gmx.com>
 <20230627142739.GB16168@twin.jikos.cz>
 <ca3f483e-38fc-786b-d85b-35d543a701a9@alu.unizg.hr>
Date:   Tue, 27 Jun 2023 14:49:15 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Mirsad Goran Todorovac" <mirsad.todorovac@alu.unizg.hr>,
        "David Sterba" <dsterba@suse.cz>
Cc:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Chris Mason" <clm@fb.com>, "Josef Bacik" <josef@toxicpanda.com>,
        "David Sterba" <dsterba@suse.com>
Subject: Re: [BUG] btrfs: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Tue, Jun 27, 2023, at 12:27 PM, Mirsad Goran Todorovac wrote:

> Thank you for your prompt response. It wasn't obvious from the kernel
> message though which .config setting needs adjustment.


https://gitlab.com/cki-project/kernel-ark/-/merge_requests/2271


> I am yet unable to tell whether the lockdep setting being too low and
> turning off the locking correctness validator caused the kernel crash, but
> I will know more after restarting the kselftest with the new lockdep
> setting ...

Lockdep is complex and so are real file system workloads, so the warnings might seem transient.

-- 
Chris Murphy

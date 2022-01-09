Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4579C488ACC
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Jan 2022 18:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236111AbiAIREM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Jan 2022 12:04:12 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:51643 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236103AbiAIREK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 9 Jan 2022 12:04:10 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id C0A6D3200C6B
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Jan 2022 12:04:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 09 Jan 2022 12:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=n
        p9z7x10GZvLhS9YjbcVKq/8RksLqI2t7jprFWovhw0=; b=SXO1hccsVfB4TmYXZ
        bo0QdPcjiomIWohurOdf3WamI7DuWGB/9Uz4w+CwxOtUUfR6sU87T+C2JOFPrmdr
        sOoL9iP5ajTqZ7gkAn83BlGjgOr5gnX27f2x+pFoRwPyS+bcU2Ny/qgBMErb2KrK
        BpaJ7fkMdR23EHdtIFDUs6qvgCnlauodxMF8URno6wvGGc/nfCQ2I0WjEE1LP8K8
        viIEMMntGYmQ529ueMbGNwasW0JMO4P1AFGtAeUmVBXC1eHP/SX9X7axkuzJNUac
        yOCfABB6BoQz1KhR5ZBAd7Yy/NGswV5JhJMAITKe22f/I8gzOuIME9rYuhVC4gKR
        qzuEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=np9z7x10GZvLhS9YjbcVKq/8RksLqI2t7jprFWovh
        w0=; b=FzFEMBCSuZtpXZWWKd+YYS+sHXcxNOPHfs0GZLoGyH/sp2WUWec/5VsCv
        hdxGH3hMgR7Vp8KdzR6ieFDIc/7+gNj+9Lnezz1f+t3n8XrZuRsvhmn+3E0W3/DK
        Gn5S55jP5B5H6KiIl98V19GEfENy4xm+46LxBCRuCcRNamDKnVBX5IV+fGR/jvyV
        6IW3IMazwlxvXCa7KR/d2i13klq1tMyBv6s95d3B+iKtuWt8b9VAgHUW1D6n56Zf
        M989NLSO13leshfC3yqMAAe2k3p7OErcDA5iX9mnGgLr8kIa36ZvIKQCofekqCom
        a1zBGE+ATG3zP70NpKosYYt5qSbTQ==
X-ME-Sender: <xms:iRXbYaqryIIBSn-csnMYZ1W8sn1PMEbVBJ9otBuE9_SRrpmh2BKtsw>
    <xme:iRXbYYrvWe4olQJ7aRyXpONBXJYJyMaOms5vj2aQmuUr3eRp0r0wTaum9BE12QRpR
    _ZjO23defUBPziTTg>
X-ME-Received: <xmr:iRXbYfNRGcBUraah0J8gy3QHOyy4C3N6DHArR3TN1ZvfdekgoQNnV38GRGB7XLPcQpcahbNXBn9nMRzqEsAy8m2oFGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegkedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtje
    ertddtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhg
    ihgrnhhithdrtghomheqnecuggftrfgrthhtvghrnhephffgfeeutddtudfhudejkeejud
    evledtudeufffhhfeukeejkeekiedtfffhffeinecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:iRXbYZ6iTxViIegrpxNXKJaswvRTaASk8GXWd0yhHqQHSF-g66jy2Q>
    <xmx:iRXbYZ717cje-dOPJ9hvOl_QTt-kn7zzC1k0DiXe88DSNRgccvi7iQ>
    <xmx:iRXbYZgkjEprXKk1mRj6IjGYL6iiajNX-yrbQgCXUoEZmsWhWEfRBw>
    <xmx:iRXbYaXJFFrRRIGGNr0s2vBWtdpV-O13E2MC1TVPHS9w-ACOwfLzEw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-btrfs@vger.kernel.org>; Sun, 9 Jan 2022 12:04:09 -0500 (EST)
Subject: Re: [bug] GNOME loses all settings following failure to resume from
 suspend
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAJCQCtRnyUHEwV1o9k565B_u_RwQ2OQqdXHtcfa-LWAbUSB7Gg@mail.gmail.com>
 <YdXdtrHb9nTYgFo7@debian9.Home>
From:   Remi Gauvin <remi@georgianit.com>
Message-ID: <301257a0-b00b-af07-e3ee-c7f91c787dce@georgianit.com>
Date:   Sun, 9 Jan 2022 12:04:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YdXdtrHb9nTYgFo7@debian9.Home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022-01-05 1:04 p.m., Filipe Manana wrote:

> After mounting the fs again 'file' is empty and 'file.tmp' does not exists.
> 
> The only for that to guarantee 'file' is not empty and has the expected
> data ("newcontent"), would be to mount with -o flushoncommit.
> 



Was flushoncommit on the default back in kernel/tools version 4.4?  I
found an old Ubuntu man page that seemed to indicate as much.  That
would be a very radical and (for me at least.) unexpected change.



Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D76848808D
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jan 2022 02:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiAHBas (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jan 2022 20:30:48 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:48557 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230185AbiAHBar (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Jan 2022 20:30:47 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 4F4043201DA0
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jan 2022 20:30:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 07 Jan 2022 20:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=to:from:subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=fm2; bh=Gg2gYtzbVJ0o7H08LqW12M/03s
        Kwhq766ZrlrXaQ/m8=; b=hqoQkiGAwDhW4yyhAJv1VmWuyQzq/+y6v2Mc0lwtTq
        cKGVoq/dUDBRzeztbQ3wUrGpLlUE/7miE1w8vhhaX7iyjxP5I/DDJzOhIDAWpnek
        0lLZ9s94kBLOcv9HR7D9gptsraYeKua1OmPtqcv4vr6xfVEMtRGViRNmsDRJAjqG
        LQLWvXzwBqf0hFeff1Q8NJLbV4q3eNEfBKSwvKyJUBsMiqMByXyRHzQ+9ejPja1g
        yAa7p01gFhuHlmMtK7d0mj+An2xVHGWSunewoDp1OnIOFwycmr0wvujlQmOlZp8J
        LPiaVUhPDARQu5ocLSqzYZRvhPAdOPYkkLCVgPD6S3DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Gg2gYt
        zbVJ0o7H08LqW12M/03sKwhq766ZrlrXaQ/m8=; b=PZrvanLlHREZ6kFUwaqHAa
        bAvM2RjJFu3EnhoC3EtbqWmx+L70FD+xXMesWQ+niSEz0AAm6vsmPcS3hJX3M0k7
        N6HbeyFHO0qBJ7vadaYxJxeB1KeXEvz69KHMI+WzMieQ+P0wUFKFAmXvJt+9FLIK
        mP1kSeH2PRizEy0CX6M3VgM2dQg94kO/MXDWkffyedCc+7WwVGvSILuMJQymyNX4
        c9ZxKlTC1hIV2NwgomURou1Lxdz/a7GwI2R+t3U5ZbeI58e+IToI3zmpMnHRMODy
        TEOj0QiQuusSQx5SItrKFZJvuqrhopgzpw7cmFNNJ9zJ8LYx4cUGXDug72u7soRA
        ==
X-ME-Sender: <xms:RunYYaLSWRcK2cKEfkfcJTa8X-fz5zUWKMNPwaM3hiqrOzlXXxjifg>
    <xme:RunYYSJXypXCgl267ezfW6-Mol0tITsAtPPBQJEChGsxXKXLkVb2RoMLplTWyg_CQ
    wuQ7h0uSiuC-USd7w>
X-ME-Received: <xmr:RunYYav9J1hzLTre8NK1gv0ADlSksCsrE059PL9AUnYTgo-UI-oOresJsKDJUve8fPqqepqL6v7CzAQyfMq_XytXnYE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegfedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefvhffukffffgggtgfgsehtjeertd
    dtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhgihgr
    nhhithdrtghomheqnecuggftrfgrthhtvghrnhepiedthfeijeduiedtudevueffudekud
    egveeggeetgfeljeeivedvveettdfhiedvnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:RunYYfYPdt_b1VFSLJveYAlaL8sRQZ7WdPZUhd6r05qwF_cXTSBdJA>
    <xmx:RunYYRaUp368pvLuv-pDkNBgCR5l8jnPpbAj0DsZA-ce9vfhxh8HOw>
    <xmx:RunYYbBtlJWkeb6d1FtnhjW26QIRGyCNf7vIxipDHRCo5uOM4mQZlQ>
    <xmx:RunYYT2M4SC583JlRbqw6PsCtddBraNVDnU25eZAsPEYk4sSVnUHXw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-btrfs@vger.kernel.org>; Fri, 7 Jan 2022 20:30:46 -0500 (EST)
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
From:   Remi Gauvin <remi@georgianit.com>
Subject: Case for "datacow-forced" option
Message-ID: <42e747ca-faf1-ed7c-9823-4ab333c07104@georgianit.com>
Date:   Fri, 7 Jan 2022 20:30:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I notice some software is silently creating files with +C attribute
without user input.  (Systemd journals, libvert qcow files, etc.)... I
can appreciate the goal of a performance boost, but I can only see this
as disaster for users of btrfs RAID, which will lead to inconsistent
mirrors on unclean shutdown, (and no way to fix, other than full balance.)

I think a datacow-forced option would be a good idea to prevent
accidental creation of critical files with nocow attribute.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15071617A04
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 10:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiKCJcm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 05:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKCJcl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 05:32:41 -0400
Received: from fallback13.mail.ru (fallback13.mail.ru [94.100.179.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2613A101D
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 02:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=F3FzfJ8CVdfZZBgd0ad6gqaVjyVXIEO6BQQQy3bnnZ4=;
        t=1667467959;x=1667557959; 
        b=I0jPjUIN8/nrok4/i6F8wDmkx6KWNoh9s48L73fupJxgk8BVVIstvhttJYIlrkZdsXToxNljF+v6YUy4wv6H5wCZJFmRl2j5BmFCiAX4eL/V/ngIAiXXPHhNAduRznOjGsRdxClA0JiSJzPfp8kmCO8UqVBnFIXY070Qz0BzCFN+I0LdqRtZijqP9R1F2gv8wvVvUjZcrtqD6K7Cx+3iellvxvijfMNR4Wi4ucHlU27ZxzZB1k+fUKBan6J0djsDqb9UfahI5sKe9G3HcPs3t1GiY3z71ebLD67M/DrIEmKNUwPkKkOkOgvdDjFAzCaWkE15vPMnxSKzdAyTsdnO8w==;
Received: from [10.161.64.54] (port=51688 helo=smtp46.i.mail.ru)
        by fallback13.m.smailru.net with esmtp (envelope-from <Nemcev_Aleksey@inbox.ru>)
        id 1oqWaS-00047p-Qp
        for linux-btrfs@vger.kernel.org; Thu, 03 Nov 2022 12:32:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=F3FzfJ8CVdfZZBgd0ad6gqaVjyVXIEO6BQQQy3bnnZ4=;
        t=1667467956;x=1667557956; 
        b=Hpb+kusMTcJVorminXo5xA7Z4HL6gvToPXmNbmlTV99KC38Hq4KLSP7+KMXCEyCs9Uo3SO/X/wWph/jhMCWAMGhNRvsXn7gsnQOAySECjpO8x1nSsPLVTgJX3+pDrukk3Fu7Fp54oIgNKLBebJviry9WDKOKXkVC2aK5WHibADlmx6nQJd7e+7HDlLmj+00ePyNfms4vT/ehsEeyVMYx3g5dZ3T/g7XzeA5AjaWyK89IfesbNl7L+gK/mQiydUsk0uuINJIsk7+rWnw2B4VN/YLSkg+rlVjIA7bdmJv6TZ9rA3rB/iHVG10jIM33Zc6HPFLAnhw8GG3LZHtuGLin/w==;
Received: by smtp46.i.mail.ru with esmtpa (envelope-from <Nemcev_Aleksey@inbox.ru>)
        id 1oqWaQ-0003vK-0m
        for linux-btrfs@vger.kernel.org; Thu, 03 Nov 2022 12:32:34 +0300
Message-ID: <6cb11fa5-c60d-e65b-0295-301a694e66ad@inbox.ru>
Date:   Thu, 3 Nov 2022 12:32:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Language: en-US
From:   Nemcev Aleksey <Nemcev_Aleksey@inbox.ru>
Subject: ERROR: invalid size for attribute, expected = 4, got = 8 on subvolume
 send
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD967121363E257EE6DC1808F33E6D3AA7BC95E715F73E8301E00894C459B0CD1B9454A83CBAB51509F909EB65D7F06B23BEC2CDF11E040D7AD7B820C60925959D8
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE705B093C0FC4B30B9EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063775FF68B4B43662428638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8E9CEB927FF74B88B77EB72420D2EF9486F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE745E5BD5EB7B96CB29FA2833FD35BB23D9E625A9149C048EEB1593CA6EC85F86DBDFBBEFFF4125B51D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B9C63C9FE3593CF42A471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FC7B383541344051413AA81AA40904B5D9CF19DD082D7633A078D18283394535A93AA81AA40904B5D98AA50765F7900637458D1332A1BF835ED81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F6228E2C7F8077EAB35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A53974FF5031988B5138B082FDD365938E55B2F8746AAC91C14EAF44D9B582CE87C8A4C02DF684249C2E763F503762DF508DC63EAE0DBA7CFC
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D3441661D6226BE8C31813F054F9A243E4805CB8A68B9F6566A5C1C646DB16A23EA59A15435241CEAEC1D7E09C32AA3244C500704FD4254FC241E839F0DBBB962223E8609A02908F2713EB3F6AD6EA9203E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXjwtqSBwflwi18UpWy2jaff
X-Mailru-Sender: 6F30CE3AAFA23F85D1B9D8D23F7101C4087B2B998B2DAAE1DFF8AB8F66648EED3C9CF741DC66499CB5D628A7EF4494575C5F6E3C72ABB53BB0D9B300F142F0238EAA47040EB6BC244E4EA347F45ED768B49EAA7E57EF395FB4A721A3011E896F
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4846457A0DDDCBDD22FEFA1C077B1515B2734D13372915E33049FFFDB7839CE9E52F8832C7BC8765A54E0A1665ECF7D0E1044DBD7BCF4A4008A7C08E8772B62EB
X-7FA49CB5: 0D63561A33F958A5F5A572CA82C001CB1B68985F81547DF0E56CBE440EA99F22CACD7DF95DA8FC8BD5E8D9A59859A8B6E3848AE611125D6DCC7F00164DA146DAFE8445B8C89999728AA50765F7900637A4BA495B1E3EA588389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC830C7C91C97108465F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C4CB6874B0BCFF0B8BA3038C0950A5D36C8A9BA7A39EFB766EC990983EF5C032935872C767BF85DA227C277FBC8AE2E8BCE529FC795333FBCEFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojYfCECMrgGhSIT6GUaBgntg==
X-Mailru-MI: 800
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello.

  I'm using Btrfs with zstd compression (subvolume property 
compression=zstd) on the PC and on the backup drive and running as a 
daemon the `bees` (on-demand deduplication tool) on the PC.

  I'm using btrfs send | btrfs receive to send incremental snapshots of 
PC subvolumes and receive them to the backup drive.
  Sometimes receive fails with ERROR: invalid size for attribute, 
expected = 4, got = 8 or ERROR: invalid size for attribute, expected = 
8, got = 4

  Why does this error happen?
  How can I debug this error? At least how to get the problem file name?
  Is that attribute an internal Btrfs-specific thing or something 
generic like xattr attribute or file attribute (lsattr/chattr)?
  Is it possible to resolve this error without removing the subvolume 
and snapshot on the backup drive and resending the complete subvolume again?

  Thank you.

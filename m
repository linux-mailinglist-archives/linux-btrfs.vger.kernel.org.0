Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F113589424
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 23:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbiHCVt3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 17:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiHCVt2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 17:49:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AB519008
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659563364;
        bh=lWXcueGTV2N1UIvIUYGBnSlbKaXeU3pg+xR8JEOvrio=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=H4KZNbtTyF67KxMasw9PGoyWWkN7r/sqj/S2//Y8UL0w3HKDdz9URTzDRiVh/oKcu
         rvoLTGNWPrWXsawWKP5hgl/l5zwDknY/QD4AUTliOOLg9GhejRz4GmqsG5TGS2pF0N
         afyHgccok8BrpOxRx3mdiFEpuyZjrNQgnn3uYlI8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mf0BG-1nlgSH18dG-00gX2c; Wed, 03
 Aug 2022 23:49:24 +0200
Message-ID: <52323456-6820-ce55-101a-8aecc3e73539@gmx.com>
Date:   Thu, 4 Aug 2022 05:49:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] btrfs: scrub: try to fix super block errors
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1659423009.git.wqu@suse.com>
 <9f95c1c4437371d8ad1b51042e5dc82a5e42449f.1659423009.git.wqu@suse.com>
 <20220803125513.GC13489@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220803125513.GC13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n+CfEibxVq72mqpnUkeGRZ6Y07/idij46tyvhOBUwcSmot1z6/6
 4vaDbQJ1f06J6pJhvaVry+Eb8X2G2vHQyigUgySJaefPzQ4ihZAakAlXwm2lgSC5hMOGWkV
 dz/edWRozGDy2ULGKUdlnoj+8Jzo1afQY0jgwaD+j94Y4e/tPMG999z1Kee65QTYzy15OFa
 Y8UfnJKfEexWkzUZP12qA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8SHWjV+kHqE=:f2lThWFSVF2fCKWCPbkBr2
 XXxUpI/ljp0M2UVSpq6DIDFtaU3filazxme33NWe3ng+F8NkS8/3UjHeBP+KrLt/6VZpKPFJp
 NKTEjGP7fDiOhqZ091gA+km+uluT5L1UjSlXqqDUFkC6HWUvYYsxMMKrGWPoeOcV1rQMClY5n
 DNuapI4QmVCnSFZgtGkamchp3lzMfQ8Xg1D0ULKoiNNhAM+ujiaP3hUor3sZF1BSPtkBQJamX
 NeZq+WzHOXl+RQSrHdarUSq4cfZo3Y6C6VbJksByjG89DpFaRaiYQ4kDhZDrPgQmkvRiBczk3
 uszGSDyg3BsTQPcr1jpSZ1ERt8F0CnOCSJCfHUuyqNxjm/asyzinXRylG0V6IoABWSHQR+P6u
 yhBF0iGe+9+BlJWElLZHiZA2UHU1L53Yc9PmerUFqMMaZ7aeW1aXMMfrRbb1wOzjPHsE4uHE+
 onwIDY6RVG+tTNqPNmJWYHgVk2TUWOUI7CWNRM3shy1UA6WUne45ftRRAjBdEQxuDJY6MqVZt
 JkdNe+YMJaLcT7u4MS64+rn1fQLmywKmamtDjWC6E+MDlCr+1fVvijunRFfzz7tC+DWDFtwu2
 gshKRYIxTBxuFufbyetGfhZvJcLeL5aJy9UVnqHFv+a8rn6ZAKXyWttCKox0+26mPpw80f3c+
 HusCVDk7RGJNb0Xw/UQi4L06vib8w2jPbZP3bw16v6legdx/U+Zdra9cxKqgCz5yQiQT+eXtF
 ohCf6PadkTAkMG7X3XMEr5BXGgVe9JjsAKwhaDUyJ3S4Hez1C+ZmIPTdjX0dwLDeL8HEHz7h4
 NFfD/NiTE3Eb4N/N5naMpsHsoHrtyY5J0WMq5AmX3i2MQKlutM8nZMuUhdP2Ui9Hvs35UyiQ5
 EpJyvXcxgUuhFlyb9xK7rlrRmn3AvaskWJPbjQUSjhAn4yNt/nF7a/n6ioIDdaN5nM5RdRsX4
 vdITHWgsyBVrmpBgMIrky640vCC4i51mhBtWmGDLboRyL4ERfNIryXKiUR56y8nwDhd4MXywM
 p9HVLOOPZfpa+G2JFS7JYzub0y2zHAJz/GjSbdzw5LiJU6HoIrmI1Opb0QH9sSJK89+M9Kkih
 RGUCQLXoU/CWr8tGXL9aXMC9LiEcHBypz4O7HbIUELlMzkBAdxgM2iYeg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/3 20:55, David Sterba wrote:
> On Tue, Aug 02, 2022 at 02:53:03PM +0800, Qu Wenruo wrote:
>> @@ -4231,6 +4248,26 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_inf=
o, u64 devid, u64 start,
>>   	scrub_workers_put(fs_info);
>>   	scrub_put_ctx(sctx);
>>
>> +	/*
>> +	 * We found some super block errors before, now try to force a
>> +	 * transaction commit, as all scrub has finished, we're safe to
>> +	 * commit a transaction.
>> +	 */
>
> Scrub can be started in read-only mode, which is basicaly report-only
> mode, so forcing the transaction commit should be also skipped. It would
> fail with -EROFS right at the beginning of transaction start.

It's already checked in the code:

+		if (sctx->stat.super_errors > old_super_errors && !sctx->readonly)
+			need_commit =3D true;

Thanks,
Qu
>
>> +	if (need_commit) {
>> +		struct btrfs_trans_handle *trans;
>> +
>> +		trans =3D btrfs_start_transaction(fs_info->tree_root, 0);
>> +		if (IS_ERR(trans)) {
>> +			ret =3D PTR_ERR(trans);
>> +			btrfs_err(fs_info,
>> +	"scrub: failed to start transaction to fix super block errors: %d", r=
et);
>> +			return ret;
>> +		}
>> +		ret =3D btrfs_commit_transaction(trans);
>> +		if (ret < 0)
>> +			btrfs_err(fs_info,
>> +	"scrub: failed to commit transaction to fix super block errors: %d", =
ret);
>> +	}
>>   	return ret;
>>   out:
>>   	scrub_workers_put(fs_info);
